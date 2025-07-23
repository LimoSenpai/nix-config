{inputs, pkgs, lib, ... }:

{
  home.packages =  with pkgs; [
    bitwarden-desktop
    kdePackages.dolphin
    vscode-fhs
    nextcloud-client
    discord
    vesktop
    arrpc
    brave
    yubikey-personalization-gui
    xfce.thunar
  ];
}

