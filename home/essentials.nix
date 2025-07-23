{inputs, pkgs, lib, ... }:

{
  home.packages =  with pkgs; [
    bitwarden-desktop
    kdePackages.dolphin
    vscode-fhs
    nextcloud-client
    discord
    brave
    yubikey-personalization-gui

  ];
}

