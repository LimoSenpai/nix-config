{ config, pkgs, lib, inputs, ... }: {
 
  options = {
    cirno.enable = lib.mkEnableOption "Cirno Downloader";
  };

  config = lib.mkIf config.cirno.enable {
    environment.systemPackages = with pkgs; [
      cirno-downloader
    ];
  };
}