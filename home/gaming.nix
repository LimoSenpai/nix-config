{inputs, pkgs, lib, ... }:

{
  home.packages =  with pkgs; [
    lutris
    wine
    protonplus
    gamescope
    linuxKernel.packages.linux_zen.xpadneo

    #lutris Icon fix
    adwaita-icon-theme
  ];
}

