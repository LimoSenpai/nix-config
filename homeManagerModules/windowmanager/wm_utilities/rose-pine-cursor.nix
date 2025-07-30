{ inputs, pkgs, lib, config, ... }: {

  options = {
    rose-pine-cursor.enable = lib.mkEnableOption "Rose Pine Cursor Theme";
  };

  config = lib.mkIf config.rose-pine-cursor.enable {
    home.packages =  with pkgs; [
      rose-pine-cursor
    ];
  };
}

