{inputs, pkgs, lib, ... }:

{
  home.packages =  with pkgs; [

    bitwarden-desktop
    vscode-fhs
    nextcloud-client
    #brave
    yubikey-personalization-gui
    streamlink-twitch-gui-bin
    thunderbird
    evolution
    obsidian
    jq
    loupe

    vesktop
    arrpc
    easyeffects

    kdePackages.dolphin
    polkit_gnome
    lxqt.lxqt-sudo

    # Nautilus and extensions
    nautilus
    nautilus-open-any-terminal
    code-nautilus
    sushi
  ];
}

