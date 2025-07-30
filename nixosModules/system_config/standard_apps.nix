
{ config, lib, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # Root Authentication
    lxqt.lxqt-sudo
    polkit_gnome

    # Default Applications
    gsettings-desktop-schemas
    man-db

    # themes
    rose-pine-hyprcursor
    hicolor-icon-theme
    adwaita-icon-theme
  ];
}