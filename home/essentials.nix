{inputs, pkgs, lib, ... }:

{
  home.packages =  with pkgs; [
    bitwarden-desktop
    kdePackages.dolphin
    rofi-wayland
    vscode-fhs
    swww
    waypaper
    grimblast
  ];
}

