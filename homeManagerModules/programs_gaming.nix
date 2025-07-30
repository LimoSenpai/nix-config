{inputs, pkgs, lib, ... }:

{
  home.packages =  with pkgs; [
    lutris
    gamescope
    linuxKernel.packages.linux_zen.xpadneo

    #wine and proton
    wine
    winetricks
    protontricks
    protonplus

    #lutris Icon fix
    adwaita-icon-theme

    cirno-downloader
    heroic-unwrapped
  ];
}

