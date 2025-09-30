{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.cursor;

  themeProfiles = {
    "google-dot-black" = {
      description = "Google Dot cursor theme in black";
      xcursorName = "GoogleDot-Black";
      hyprcursorName = null;
      packages = [ pkgs.google-cursor ];
      package = pkgs.google-cursor;
    };
    "google-dot-blue" = {
      description = "Google Dot cursor theme in blue";
      xcursorName = "GoogleDot-Blue";
      hyprcursorName = null;
      packages = [ pkgs.google-cursor ];
      package = pkgs.google-cursor;
    };
    "google-dot-red" = {
      description = "Google Dot cursor theme in red";
      xcursorName = "GoogleDot-Red";
      hyprcursorName = null;
      packages = [ pkgs.google-cursor ];
      package = pkgs.google-cursor;
    };
    "google-dot-white" = {
      description = "Google Dot cursor theme in white";
      xcursorName = "GoogleDot-White";
      hyprcursorName = null;
      packages = [ pkgs.google-cursor ];
      package = pkgs.google-cursor;
    };
    "future-cursors" = {
      description = "Future Cursors inspired by macOS";
      xcursorName = "Future-Cursors";
      hyprcursorName = null;
      packages = [ pkgs.future-cursors ];
      package = pkgs.future-cursors;
    };
    "point-er-blackplus" = {
      description = "Point.er Black+ cursor theme";
      xcursorName = "Point.er-BlackPlus";
      hyprcursorName = null;
      packages = [ pkgs.point-er-cursors ];
      package = pkgs.point-er-cursors;
    };
  };

  selectedTheme = themeProfiles.${cfg.theme};
in
{

  options.cursor = {
    enable = lib.mkEnableOption "Cursor Theme";

    theme = lib.mkOption {
      type = lib.types.enum (lib.attrNames themeProfiles);
      default = "point-er-blackplus";
      description = ''
        Select the default cursor theme. Available themes include the Point.er conversion,
        Google Dot variants, and Future Cursors.
      '';
    };

    resolvedTheme = lib.mkOption {
      type = lib.types.str;
      readOnly = true;
      internal = true;
      description = "Resolved Xcursor theme name derived from the selected profile.";
    };

    resolvedHyprcursorTheme = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      readOnly = true;
      internal = true;
      description = "Resolved Hyprcursor theme name derived from the selected profile, or null if unavailable.";
    };

    resolvedSize = lib.mkOption {
      type = lib.types.int;
      readOnly = true;
      internal = true;
      description = "Resolved cursor size in pixels for downstream consumers.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.unique (
      selectedTheme.packages ++ [
      pkgs.future-cursors       # X11 cursors
      pkgs.google-cursor        # Google Dot cursor variants
      pkgs.point-er-cursors     # Converted Point.er cursor pack
      pkgs.bibata-cursors       # Fallback X11 cursors
      pkgs.bibata-hyprcursor    # Hyprcursors (kept for compatibility)
    ]);

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = selectedTheme.xcursorName;
      size = 25; # Size in pixels
      package = selectedTheme.package;
    };

    # Expose resolved cursor theme metadata for other modules (e.g. Hyprland)
    cursor = {
      resolvedTheme = selectedTheme.xcursorName;
      resolvedHyprcursorTheme = selectedTheme.hyprcursorName;
      resolvedSize = 25;
    };
  };
}