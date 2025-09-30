#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 || $# -gt 3 ]]; then
  echo "Usage: $0 <source-dir> <output-dir> [target-size]" >&2
  exit 1
fi

SRC=$1
OUT=$2
TARGET_SIZE=${3:-}

if [[ -n "$TARGET_SIZE" ]]; then
  if ! [[ "$TARGET_SIZE" =~ ^[0-9]+$ ]] || [[ "$TARGET_SIZE" -le 0 ]]; then
    echo "Target size must be a positive integer" >&2
    exit 1
  fi
fi

RESIZE_TOOL=""
if [[ -n "$TARGET_SIZE" ]]; then
  if command -v magick >/dev/null 2>&1; then
    RESIZE_TOOL="magick convert"
  elif command -v convert >/dev/null 2>&1; then
    RESIZE_TOOL="convert"
  else
    echo "Missing required tool: convert (ImageMagick)" >&2
    exit 1
  fi
fi

for tool in xcursorgen icotool; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "Missing required tool: $tool" >&2
    exit 1
  fi
done

sanitize() {
  local name="$1"
  name="${name// /-}"
  name="${name//+/Plus}"
  echo "$name"
}

make_cfg() {
  local png=$1
  local size=$2
  local hx=$3
  local hy=$4
  local tmp=$5
  cat <<EOF >"$tmp"
$size $hx $hy $png
EOF
}

build_static_cursor() {
  local base_dir=$1
  local basename=$2
  local target=$3
  local png_path="$base_dir/Png/${basename}.png"
  local cur_path="$base_dir/${basename}.cur"
  if [[ ! -f "$png_path" ]]; then
    echo "Missing PNG for $basename in $base_dir" >&2
    exit 1
  fi
  if [[ ! -f "$cur_path" ]]; then
    echo "Missing CUR for $basename in $base_dir" >&2
    exit 1
  fi

  local info
  info=$(icotool -l "$cur_path" | tail -n1)
  local size
  size=$(sed -E 's/.*--width=([0-9]+).*/\1/' <<<"$info")
  local hx
  hx=$(sed -E 's/.*hotspot-x=([0-9]+).*/\1/' <<<"$info")
  local hy
  hy=$(sed -E 's/.*hotspot-y=([0-9]+).*/\1/' <<<"$info")

  local cfg
  cfg=$(mktemp)
  local tmp_dir
  tmp_dir=$(mktemp -d)
  local local_png="$tmp_dir/image.png"

  local target_size=${TARGET_SIZE:-$size}
  local hx_scaled=$hx
  local hy_scaled=$hy
  if [[ -n "$TARGET_SIZE" && "$target_size" -ne "$size" ]]; then
    hx_scaled=$(( (hx * target_size + size / 2) / size ))
    hy_scaled=$(( (hy * target_size + size / 2) / size ))
    if [[ -n "$RESIZE_TOOL" ]]; then
      if [[ "$RESIZE_TOOL" == "magick convert" ]]; then
        magick convert "$png_path" -resize "${target_size}x${target_size}" "$local_png"
      else
        convert "$png_path" -resize "${target_size}x${target_size}" "$local_png"
      fi
    else
      cp "$png_path" "$local_png"
    fi
  else
    cp "$png_path" "$local_png"
  fi

  make_cfg "$local_png" "$target_size" "$hx_scaled" "$hy_scaled" "$cfg"
  xcursorgen "$cfg" "$target"
  rm "$cfg"
  rm -r "$tmp_dir"
}

build_anim_cursor() {
  local base_dir=$1
  local variant=$2
  local target=$3
  local subdir=$4
  local delay=$5
  local size=${6:-64}
  local hx=${7:-32}
  local hy=${8:-32}
  local frames_dir="$base_dir/Png/$subdir"
  if [[ ! -d "$frames_dir" ]]; then
    echo "Missing animation frames for $subdir in $base_dir" >&2
    exit 1
  fi
  local frames=()
  while IFS= read -r -d '' frame; do
    frames+=("$frame")
  done < <(find "$frames_dir" -maxdepth 1 -type f -name '*.png' -print0 | sort -z)
  if [[ ${#frames[@]} -eq 0 ]]; then
    echo "No frames found for $subdir in $base_dir" >&2
    exit 1
  fi
  local cfg
  cfg=$(mktemp)
  local tmp_dir
  tmp_dir=$(mktemp -d)
  : >"$cfg"
  local idx=0
  local target_size=${TARGET_SIZE:-$size}
  local hx_scaled=$hx
  local hy_scaled=$hy
  if [[ -n "$TARGET_SIZE" && "$target_size" -ne "$size" ]]; then
    hx_scaled=$(( (hx * target_size + size / 2) / size ))
    hy_scaled=$(( (hy * target_size + size / 2) / size ))
  fi
  for frame in "${frames[@]}"; do
    idx=$((idx + 1))
    local local_frame
    printf -v local_frame "%s/frame-%02d.png" "$tmp_dir" "$idx"
    if [[ -n "$TARGET_SIZE" && "$target_size" -ne "$size" && -n "$RESIZE_TOOL" ]]; then
      if [[ "$RESIZE_TOOL" == "magick convert" ]]; then
        magick convert "$frame" -resize "${target_size}x${target_size}" "$local_frame"
      else
        convert "$frame" -resize "${target_size}x${target_size}" "$local_frame"
      fi
    else
      cp "$frame" "$local_frame"
    fi
    echo "$target_size $hx_scaled $hy_scaled $local_frame $delay" >>"$cfg"
  done
  xcursorgen "$cfg" "$target"
  rm "$cfg"
  rm -r "$tmp_dir"
}

mkdir -p "$OUT"

mapfile -t variants < <(find "$SRC" -maxdepth 1 -mindepth 1 -type d -printf '%f\n' | sort)

if [[ ${#variants[@]} -eq 0 ]]; then
  echo "No variants found in $SRC" >&2
  exit 1
fi

for variant in "${variants[@]}"; do
  base_dir="$SRC/$variant"
  if [[ ! -f "$base_dir/.Install.inf" ]]; then
    continue
  fi

  theme_name=$(sanitize "$variant")
  theme_dir="$OUT/$theme_name"
  cursors_dir="$theme_dir/cursors"
  mkdir -p "$cursors_dir"

  declare -A primary
  primary[left_ptr]=pointer
  primary[question_arrow]=help
  primary[crosshair]=cross
  primary[xterm]=text
  primary[pencil]=handwriting
  primary[not-allowed]=unavailiable
  primary[sb_v_double_arrow]=vert
  primary[sb_h_double_arrow]=horz
  primary[bottom_right_corner]=dgn1
  primary[top_left_corner]=dgn1
  primary[bottom_left_corner]=dgn2
  primary[top_right_corner]=dgn2
  primary[fleur]=move
  primary[up_arrow]=alternate
  primary[hand2]=link
  primary[person]=pin
  primary[pin]=person

  for cursor in "${!primary[@]}"; do
    build_static_cursor "$base_dir" "${primary[$cursor]}" "$cursors_dir/$cursor"
  done

  # Animated cursors
  build_anim_cursor "$base_dir" "$variant" "$cursors_dir/left_ptr_watch" "Work" 40 64 32 32
  build_anim_cursor "$base_dir" "$variant" "$cursors_dir/watch" "Busy" 40 64 32 32

  while read -r alias target; do
    [[ -z "$alias" ]] && continue
    ln -sf "$target" "$cursors_dir/$alias"
  done <<'ALIASES'
left_arrow left_ptr
right_ptr left_ptr
pointer left_ptr
default left_ptr
arrow left_ptr
hand1 hand2
hand hand2
pointing_hand hand2
link hand2
copy pin
alias pin
person_icon person
progress left_ptr_watch
3ecb610c1bf2410f44200f48c40d3599 left_ptr_watch
08e8e1c95fe2fc01f976f1e063a24ccd left_ptr
wait watch
watch_s watch
loading watch
03b6e0fcb3499374a867c041f52298f0 not-allowed
forbidden not-allowed
circle not-allowed
cross crosshair
tcross crosshair
plus crosshair
text xterm
ibeam xterm
draft pencil
grabbing fleur
openhand fleur
dnd-move fleur
size_all fleur
move fleur
col-resize sb_h_double_arrow
ew-resize sb_h_double_arrow
h_double_arrow sb_h_double_arrow
row-resize sb_v_double_arrow
ns-resize sb_v_double_arrow
v_double_arrow sb_v_double_arrow
nw-resize top_left_corner
se-resize bottom_right_corner
ne-resize top_right_corner
sw-resize bottom_left_corner
top_side sb_v_double_arrow
bottom_side sb_v_double_arrow
left_side sb_h_double_arrow
right_side sb_h_double_arrow
ul_angle top_left_corner
ur_angle top_right_corner
ll_angle bottom_left_corner
lr_angle bottom_right_corner
up-arrow up_arrow
center_ptr up_arrow
person-select person
pin-select pin
ALIASES

  theme_size=${TARGET_SIZE:-25}

  cat >"$theme_dir/index.theme" <<EOF
[Icon Theme]
Name=$theme_name
Comment=Converted Point.er cursor theme ($variant)
Inherits=default
Directories=cursors

[cursors]
Size=$theme_size
Type=Fixed
EOF

  cat >"$theme_dir/cursor.theme" <<EOF
[Cursor Theme]
Name=$theme_name
Comment=Converted Point.er cursor theme ($variant)
EOF

done
