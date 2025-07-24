{inputs, pkgs, lib, ... }:

{
  home.packages =  with pkgs; [

    bitwarden-desktop
    vscode-fhs
    nextcloud-client
    brave
    yubikey-personalization-gui
    streamlink-twitch-gui-bin

    vesktop
    arrpc
    easyeffects

    kdePackages.dolphin
    xfce.thunar
    polkit_gnome
    lxqt.lxqt-sudo
    
  ];
}

