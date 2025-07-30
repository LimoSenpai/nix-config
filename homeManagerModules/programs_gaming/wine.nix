{ inputs, pkgs, lib, config, ... }: {

  options = {
    wine.enable = lib.mkEnableOption "Wine - Compatibility Layer";
  };

  config = lib.mkIf config.wine.enable {
    home.packages =  with pkgs; [
      wine
      winetricks
    ];
  };
}

