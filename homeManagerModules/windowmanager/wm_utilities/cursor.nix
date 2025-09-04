{ inputs, pkgs, lib, config, ... }: {

  options = {
    cursor.enable = lib.mkEnableOption "Cursor Theme";
  };

  config = lib.mkIf config.cursor.enable {
    home.packages = with pkgs; [
      future-cursors       # X11 cursors
      bibata-cursors       # Fallback X11 cursors
      bibata-hyprcursor    # Hyprcursors (kept for compatibility)
    ];

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Future-Cursors";
      size = 40; # Size in pixels
      package = pkgs.future-cursors;
    };
  };
}