{ inputs, pkgs, lib, config, stylix, ... }:
{
    options = {
      hyprlock.enable = lib.mkEnableOption "Hyprlock - Lockscreen";
    };

    config = lib.mkIf config.hyprlock.enable {
    home.file = {
      ".config/hypr/hyprlock.conf".text = ''
          # BACKGROUND
          background {
              monitor =
              path = ~/.config/nix-config/assets/wallpapers/hyprlock.png
              blur_passes = 2
              contrast = 0.8916
              brightness = 0.8172
              vibrancy = 0.1696
              vibrancy_darkness = 0.0
          }

          # GENERAL
          general {
              grace = 0
          }

          # Day
          label {
              monitor =
              text = cmd[update:1000] echo -e "$(date +"%A")"
              color = rgba(216, 222, 233, 0.70)
              font_size = 90
              font_family = SF Pro Display Bold
              position = 0, 350
              halign = center
              valign = center
          }

          # Date-Month
          label {
              monitor =
              text = cmd[update:1000] echo -e "$(date +"%d %B")"
              color = rgba(216, 222, 233, 0.70)
              font_size = 40
              font_family = SF Pro Display Bold
              position = 0, 250
              halign = center
              valign = center
          }

          # Time
          label {
              monitor =
              text = cmd[update:1000] echo "<span>$(date +"- %I:%M -")</span>"
              color = rgba(216, 222, 233, 0.70)
              font_size = 20
              font_family = SF Pro Display Bold
              position = 0, 190
              halign = center
              valign = center
          }

          # Profile Photo - Commented out since we don't have a profile image
          # Uncomment and set a custom image path if you have one
          # image {
          #     monitor =
          #     path = ~/.config/hypr/profile.png
          #     border_size = 2
          #     border_color = rgba(255, 255, 255, .65)
          #     size = 130
          #     rounding = -1
          #     rotate = 0
          #     reload_time = -1
          #     reload_cmd = 
          #     position = 0, 40
          #     halign = center
          #     valign = center
          # }

          # USER-BOX
          shape {
              monitor =
              size = 300, 60
              color = rgba(255, 255, 255, .1)
              rounding = -1
              border_size = 0
              border_color = rgba(255, 255, 255, 0)
              rotate = 0
              xray = false

              position = 0, -130
              halign = center
              valign = center
          }

          # USER
          label {
              monitor =
              text = $USER
              color = rgba(216, 222, 233, 0.80)
              font_size = 18
              font_family = SF Pro Display Bold
              position = 0, -130
              halign = center
              valign = center
          }

          # INPUT FIELD
          input-field {
              monitor =
              size = 300, 60
              outline_thickness = 2
              dots_size = 0.2
              dots_spacing = 0.2
              dots_center = true
              outer_color = rgba(255, 255, 255, 0)
              inner_color = rgba(255, 255, 255, 0.1)
              font_color = rgb(200, 200, 200)
              fade_on_empty = false
              font_family = SF Pro Display Bold
              placeholder_text = <i><span foreground="##ffffff99">🔒 Enter Pass</span></i>
              hide_input = false
              position = 0, -210
              halign = center
              valign = center
          }

          # Power
          label {
              monitor =
              text = 󰐥  󰜉  󰤄
              color = rgba(255, 255, 255, 0.6)
              font_size = 50
              position = 0, 100
              halign = center
              valign = bottom
          }
      '';
    };
  };
}