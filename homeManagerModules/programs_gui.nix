{inputs, pkgs, lib, ... }:

{
  home.packages =  with pkgs; [
    yubikey-personalization-gui
    streamlink-twitch-gui-bin
    loupe
    vesktop
    arrpc
    easyeffects
  ];
}

