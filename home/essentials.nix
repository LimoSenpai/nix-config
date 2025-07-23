{inputs, pkgs, lib, ... }:

{
  home.packages =  with pkgs; [
    bitwarden-desktop
    kdePackages.dolphin
    pcmanfm
    vscode-fhs
    nextcloud-client
    discord
    brave
    yubikey-personalization-gui

  ];
}

