{ inputs, pkgs, lib, config, ... }: {

  options = {
    cursor.enable = lib.mkEnableOption "Cursor Theme";
  };

  config = lib.mkIf config.cursor.enable {
    home.packages =  with pkgs; [
      bibata-cursors
    ];
  };
}

