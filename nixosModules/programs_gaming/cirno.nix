{ config, pkgs, lib, inputs, ... }: {
 
  options = {
    cirno.enable = lib.mkEnableOption "Cirno Downloader";
  };

  config = lib.mkIf config.cirno.enable {
    nixos-apps-gaming.enable = [
      "cirno-downloader"
    ];
  };
}