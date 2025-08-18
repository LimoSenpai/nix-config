
{ config, lib, pkgs, ... }: {

  options = {
    standard-apps.enable = lib.mkEnableOption "Standard Applications";
  };

  config = lib.mkIf config.standard-apps.enable {
    environment.systemPackages = with pkgs; [

    geteduroam


    # Root Authentication
    lxqt.lxqt-sudo
    polkit_gnome

    # themes
    hicolor-icon-theme
    adwaita-icon-theme

    #CLI Tools
    evtest

    git
    nano
    wget
    bluez
    glib
    zip
    xz
    unzip
    p7zip
    kdePackages.ark
    nvtopPackages.v3d

    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    btop
    iotop
    iftop
    nvtopPackages.v3d

    lsof

    sysstat
    lm_sensors 
    ethtool
    pciutils
    usbutils

    # I forgot for what this was
    gsettings-desktop-schemas
    man-db
    ];
  };  
}