
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    nano
    wget
    pavucontrol
    nwg-displays
    bluez
    gsettings-desktop-schemas
    glib
    man-db

    # theme
    rose-pine-hyprcursor
    gruvbox-plus-icons
    hicolor-icon-theme

    #cirno
    libxml2
    webkitgtk_4_1
    p7zip
  ];
  

  programs.nix-ld.enable = true;

  environment.variables = {
    XCURSOR_THEME = "BreezeX-RosePine";
    XCURSOR_SIZE = 26;
    HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    HYPRCURSOR_SIZE = 26;
    NIXOS_OZONE = "1"; # Enable Ozone for Hyprland
  };
  
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        .zen-wrapped
      ''; # or just "zen" if you use unwrapped package
      mode = "0755";
    };
  };

  # services
  services.power-profiles-daemon.enable = true;
  services.blueman.enable = true; # Optional, for GUI
  services.dbus.packages = [ pkgs.blueman ];

  #hardware 
  hardware.bluetooth.enable = true;
  hardware.graphics.enable32Bit = true;
}