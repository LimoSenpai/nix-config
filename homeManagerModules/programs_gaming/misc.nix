{ inputs, pkgs, lib, config, ... }: {

  options = {
    gaming_miscellaneous.enable = lib.mkEnableOption "Small Gaming Utilities";
  };

  config = lib.mkIf config.gaming_miscellaneous.enable {
    home.packages =  with pkgs; [
    cirno-downloader
    linuxKernel.packages.linux_zen.xpadneo
    ];
  };
}

