{ inputs, pkgs, lib, config, ... }: {

  options = {
    lutris.enable = lib.mkEnableOption "Lutris - Game Manager";
  };

  config = lib.mkIf config.lutris.enable {
    home.packages =  with pkgs; [
      lutris
    ];
  };
}

