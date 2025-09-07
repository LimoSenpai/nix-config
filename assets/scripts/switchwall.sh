#!/usr/bin/env bash
# Wallpaper switching script that works with both GNOME and Wayland compositors
# - GNOME: Uses gsettings to set wallpaper
# - Wayland compositors (Hyprland, etc.): Uses swww to set wallpaper
set -e

NIXCONFIG="$HOME/.config/nix-config"
STYLIX_FILE="$NIXCONFIG/nixosModules/stylix.nix"
WALLPAPER_DIR="$NIXCONFIG/assets/wallpapers"
TARGET_LINK="$WALLPAPER_DIR/current_wallpaper.jpg"
WAYPAPER_INI="$HOME/.config/waypaper/config.ini"

# Detect current host and set appropriate flake path
HOSTNAME=$(hostname)
case "$HOSTNAME" in
    "nixos-desktop")
        FLAKE_PATH="$NIXCONFIG/hosts/desktop-pc"
        FLAKE_CONFIG="nixos-desktop"
        ;;
    "nixosMBP")
        FLAKE_PATH="$NIXCONFIG/hosts/MBP"
        FLAKE_CONFIG="nixosMBP"
        ;;
    "nixos-thinkcentre")
        FLAKE_PATH="$NIXCONFIG/hosts/thinkcentre"
        FLAKE_CONFIG="nixos-thinkcentre"
        ;;
    *)
        echo "Unknown hostname: $HOSTNAME. Please update the script with your host configuration."
        echo "Available hosts: desktop-pc, nixosMBP, nixos-thinkcentre"
        exit 1
        ;;
esac

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
    
    # Detect desktop environment and set wallpaper accordingly
    if [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]] || [[ "$DESKTOP_SESSION" == "gnome" ]]; then
      # GNOME environment - use gsettings
      if command -v gsettings &>/dev/null; then
        if gsettings set org.gnome.desktop.background picture-uri "file://$SELECTED_WALLPAPER" && \
           gsettings set org.gnome.desktop.background picture-uri-dark "file://$SELECTED_WALLPAPER"; then
          echo "GNOME wallpaper set successfully."
          pkill waypaper
          break
        else
          echo "Failed to set GNOME wallpaper. Try again."
        fi
      else
        echo "gsettings not found! Cannot set GNOME wallpaper."
        pkill waypaper
        exit 1
      fi
    elif command -v swww &>/dev/null; then
      # Wayland compositor (Hyprland, etc.) - use swww
      if swww img "$SELECTED_WALLPAPER"; then
        echo "swww successfully set the wallpaper."
        pkill waypaper
        break
      else
        echo "swww failed to set the wallpaper. Try again."
      fi
    else
      echo "No supported wallpaper setter found!"
      echo "For GNOME: gsettings is required"
      echo "For Wayland compositors: swww is required"
      pkill waypaper
      exit 1
    fi
  fi
done

# Copy selected wallpaper to flake location
mkdir -p "$WALLPAPER_DIR"
rm -f "$TARGET_LINK"
cp "$SELECTED_WALLPAPER" "$TARGET_LINK"

# Update stylix config based on host
case "$HOSTNAME" in
    "desktop-pc")
        # For desktop-pc, the flake is in hosts/desktop-pc/, so assets are at ../../assets
        sed -i 's|image = inputs\.self \+ .*$|image = inputs.self + "/../../assets/wallpapers/current_wallpaper.jpg";|' "$STYLIX_FILE"
        ;;
    "nixosMBP")
        # For MBP, if flake is in hosts/MBP/, assets are at ../../assets
        sed -i 's|image = inputs\.self \+ .*$|image = inputs.self + "/../../assets/wallpapers/current_wallpaper.jpg";|' "$STYLIX_FILE"
        ;;
    "nixos-thinkcentre")
        # For MBP, if flake is in hosts/MBP/, assets are at ../../assets
        sed -i 's|image = inputs\.self \+ .*$|image = inputs.self + "/../../assets/wallpapers/current_wallpaper.jpg";|' "$STYLIX_FILE"
        ;;
esac

# git add (optional)
git -C "$NIXCONFIG" add "$TARGET_LINK"

# NixOS rebuild
lxqt-sudo nixos-rebuild switch --flake "$FLAKE_PATH#$FLAKE_CONFIG"
