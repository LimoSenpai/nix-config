{ inputs, pkgs, lib, config, ... }: {

  options = {
    cursor.enable = lib.mkEnableOption "Cursor Theme";
  };

  config = lib.mkIf config.cursor.enable {
    home.packages = with pkgs; [
      bibata-cursors        # X11 cursors
      bibata-hyprcursor     # Hyprcursors
    ];

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Bibata-Modern-Classic";
      size = 28; # Size in pixels
      package = pkgs.bibata-cursors;
    };
  };
}

