{ inputs, pkgs, lib, config, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
in {

  options = {
    rofi-wayland.enable = lib.mkEnableOption "Rofi - Application Launcher";
  };

  config = lib.mkIf config.rofi-wayland.enable {
    #home.packages =  with pkgs; [
    #  rofi-wayland
    #];
    stylix.targets.rofi.enable = false;
    programs = {
      rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
  # Hint: bind this in Hyprland, e.g.:
  # bind = SUPER, D, exec, rofi -show drun
          theme = lib.mkForce {
          # Configuration
          "configuration" = {
            modi = "drun,filebrowser,window";
            show-icons = true;
            display-drun = "APPS";
            display-run = "RUN";
            display-filebrowser = "FILES";
            display-window = "WINDOW";
            drun-display-format = "{name}\\n[<span weight='light' size='small'><i>({generic})</i></span>]";
            window-format = "Class : {c}\\nWorkspace : {w}";
          };

          # Global Properties
          "*" = {
            font = "Iosevka Nerd Font 10";
          };

          # Main Window
          "window" = {
            # properties for window widget
            location = mkLiteral "center";
            anchor = mkLiteral "center";
            fullscreen = false;
            width = mkLiteral "1000px";
            "x-offset" = mkLiteral "0px";
            "y-offset" = mkLiteral "0px";

            # properties for all widgets
            enabled = true;
            margin = mkLiteral "0px";
            padding = mkLiteral "0px";
            border-radius = mkLiteral "12px";
            cursor = mkLiteral "default";
            # background-image is optional; enable if the file exists or package the asset via HM
            # background-image = mkLiteral "url(\"~/.config/rofi/images/gradient.png\", width)";
          };

          # Main Box
          "mainbox" = {
            enabled = true;
            spacing = mkLiteral "20px";
            margin = mkLiteral "40px";
            padding = mkLiteral "40px";
            border-radius = mkLiteral "12px";
            background-color = mkLiteral "white/50%";
            children = map mkLiteral [ "inputbar" "mode-switcher" "listview" ];
          };

          # Inputbar
          "inputbar" = {
            enabled = true;
            spacing = mkLiteral "0px";
            margin = mkLiteral "0px 10%";
            padding = mkLiteral "0px 0px 10px 0px";
            border = mkLiteral "0px 0px 2px 0px";
            border-radius = mkLiteral "0px";
            border-color = mkLiteral "gray/20%";
            background-color = mkLiteral "transparent";
            children = map mkLiteral [ "entry" ];
          };

          "entry" = {
            enabled = true;
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "gray";
            cursor = mkLiteral "text";
            placeholder = "Type to filter";
            placeholder-color = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.5";
          };

          # Listview
          "listview" = {
            enabled = true;
            columns = 3;
            lines = 3;
            cycle = true;
            dynamic = true;
            scrollbar = false;
            layout = mkLiteral "vertical";
            reverse = false;
            fixed-height = true;
            fixed-columns = true;

            spacing = mkLiteral "40px";
            margin = mkLiteral "0px";
            padding = mkLiteral "20px 0px 0px 0px";
            border = mkLiteral "0px solid";
            background-color = mkLiteral "transparent";
            cursor = mkLiteral "default";
          };

          # Elements
          "element" = {
            enabled = true;
            spacing = mkLiteral "10px";
            margin = mkLiteral "0px";
            padding = mkLiteral "15px";
            border = mkLiteral "1px solid";
            border-radius = mkLiteral "8px";
            border-color = mkLiteral "gray/30%";
            background-color = mkLiteral "white";
            text-color = mkLiteral "black";
            cursor = mkLiteral "pointer";
          };

          "element normal.active" = {
            background-color = mkLiteral "#67FF80";
            text-color = mkLiteral "black";
          };

          "element selected.normal" = {
            background-color = mkLiteral "#FDD66F";
            text-color = mkLiteral "black";
          };

          "element selected.active" = {
            background-color = mkLiteral "#FF7F7C";
            text-color = mkLiteral "black";
          };

          "element-icon" = {
            background-color = mkLiteral "transparent";
            size = mkLiteral "48px";
            cursor = mkLiteral "inherit";
          };

          "element-text" = {
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
            cursor = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };

          # Mode Switcher
          "mode-switcher" = {
            enabled = true;
            expand = false;
            spacing = mkLiteral "20px";
            margin = mkLiteral "0px 10%";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "white";
          };

          "button" = {
            font = "Iosevka Nerd Font Bold 10";
            padding = mkLiteral "6px";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "100%";
            background-color = mkLiteral "#719DF9";
            text-color = mkLiteral "inherit";
            cursor = mkLiteral "pointer";
          };

          "button selected" = {
            background-color = mkLiteral "#F37277";
            text-color = mkLiteral "inherit";
          };

          # Message
          "error-message" = {
            padding = mkLiteral "20px";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "black";
          };

          "textbox" = {
            padding = mkLiteral "20px";
            border-radius = mkLiteral "12px";
            background-color = mkLiteral "white/30%";
            text-color = mkLiteral "black";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };
        };
      };
    };
  };
}

