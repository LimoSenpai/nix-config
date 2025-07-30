{ inputs, pkgs, lib, config, ... }: {

  options = {
    gamescope.enable = lib.mkEnableOption "Gamescope";
  };

  config = lib.mkIf config.gamescope.enable {
    home.packages =  with pkgs; [
    gamescope
    ];
  };
}

