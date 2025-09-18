{ inputs, pkgs, lib, config, stylix, ... }:
let  
  colors = config.lib.stylix.colors.withHashtag;
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
        package = pkgs.rofi;

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
            #margin = mkLiteral "40px";
            padding = mkLiteral "40px";
            border-radius = mkLiteral "12px";
            background-color = mkLiteral "${colors.base00}";
            border = mkLiteral "2px solid";
            border-color = mkLiteral "${colors.base0D}";
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
            border-color = mkLiteral "${colors.base0D}";
            background-color = mkLiteral "transparent";
            children = map mkLiteral [ "entry" ];
          };

          "entry" = {
            enabled = true;
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "${colors.base07}";
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
            border-color = mkLiteral "${colors.base0D}";
            background-color = mkLiteral "${colors.base00}";
            text-color = mkLiteral "${colors.base05}";
            cursor = mkLiteral "pointer";
          };

          "element normal.active" = {
            background-color = mkLiteral "${colors.base0D}";
            text-color = mkLiteral "${colors.base0B}";
          };

          "element selected.normal" = {
            background-color = mkLiteral "${colors.base01}";
            text-color = mkLiteral "${colors.base05}";
          };

          "element selected.active" = {
            background-color = mkLiteral "${colors.base0A}";
            text-color = mkLiteral "${colors.base05}";
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
            text-color = mkLiteral "${colors.base05}";
          };

          "button" = {
            font = "Iosevka Nerd Font Bold 10";
            padding = mkLiteral "6px";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "100%";
            background-color = mkLiteral "${colors.base00}";
            text-color = mkLiteral "inherit";
            cursor = mkLiteral "pointer";
          };

          "button selected" = {
            background-color = mkLiteral "${colors.base03}";
            text-color = mkLiteral "inherit";
          };

          # Message
          "error-message" = {
            padding = mkLiteral "20px";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "${colors.base05}";
          };

          "textbox" = {
            padding = mkLiteral "20px";
            border-radius = mkLiteral "12px";
            background-color = mkLiteral "${colors.base02}";
            text-color = mkLiteral "${colors.base05}";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };
        };
      };
    };
  };
}

