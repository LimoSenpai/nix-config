{ inputs, pkgs, lib, config, ... }: {

  options = {
    gamemode.enable = lib.mkEnableOption "Gamemode";
  };

  config = lib.mkIf config.gamemode.enable {
    home.packages =  with pkgs; [
    gamemode
    ];
  };
}

