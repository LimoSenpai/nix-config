{ pkgs, lib, config, ... }:
{
  options.gaming_miscellaneous.enable = lib.mkEnableOption "Small gaming utilities";

  config = lib.mkIf config.gaming_miscellaneous.enable {
    home.packages = [
      pkgs.cirno-downloader
      pkgs.linuxKernel.packages.linux_zen.xpadneo
    ];
  };
}
