#!/usr/bin/env bash
set -e

NIXCONFIG="$HOME/.config/nix-config"
STYLIX_FILE="$NIXCONFIG/nixosModules/stylix.nix"
WALLPAPER_DIR="$NIXCONFIG/assets/wallpapers"
TARGET_LINK="$WALLPAPER_DIR/current_wallpaper.jpg"
WAYPAPER_INI="$HOME/.config/waypaper/config.ini"

OLD_WALLPAPER=$(awk -F'=' '/^wallpaper[ ]*=/{gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}' "$WAYPAPER_INI")
OLD_WALLPAPER="${OLD_WALLPAPER/#\~/$HOME}"

waypaper &

echo "Please select a new wallpaper in waypaper and hit Apply..."

while true; do
  sleep 1
  SELECTED_WALLPAPER=$(awk -F'=' '/^wallpaper[ ]*=/{gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}' "$WAYPAPER_INI")
  SELECTED_WALLPAPER="${SELECTED_WALLPAPER/#\~/$HOME}"

  if [[ -f "$SELECTED_WALLPAPER" ]] && [[ "$SELECTED_WALLPAPER" != "$OLD_WALLPAPER" ]]; then
    echo "Selected wallpaper: $SELECTED_WALLPAPER"
    # Try to set with swww, capture output
    if command -v swww &>/dev/null; then
      if swww img "$SELECTED_WALLPAPER"; then
        echo "swww successfully set the wallpaper."
        pkill waypaper
        break
      else
        echo "swww failed to set the wallpaper. Try again."
      fi
    else
      echo "swww not found! Please install swww."
      pkill waypaper
      exit 1
    fi
  fi
done

# Copy selected wallpaper to flake location
mkdir -p "$WALLPAPER_DIR"
rm -f "$TARGET_LINK"
cp "$SELECTED_WALLPAPER" "$TARGET_LINK"

# Update stylix config
sed -i 's|image = inputs\.self \+ .*$|image = inputs.self + "/assets/wallpapers/current_wallpaper.jpg";|' "$STYLIX_FILE"

# git add (optional)
git -C "$NIXCONFIG" add "$TARGET_LINK"

# NixOS rebuild
lxqt-sudo nixos-rebuild switch --flake "$NIXCONFIG#nixos"
