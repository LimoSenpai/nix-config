{inputs, pkgs, lib, ... }:

{
  home.packages =  with pkgs; [

    bitwarden-desktop
    vscode-fhs
    nextcloud-client
    vesktop
    arrpc
    brave
    yubikey-personalization-gui
    streamlink-twitch-gui-bin


    kdePackages.dolphin
    xfce.thunar
    polkit_gnome
    lxqt.lxqt-sudo
    
  ];
}

