{ config, lib, pkgs, inputs, ... }:

{
  imports = [ 
      ../../homeManagerModules
    ];

  # The username and home directory for the user
  home.username = "tinus";
  home.homeDirectory = "/home/tinus";
  
  # default Programs
  home.sessionVariables = {
    XDG_DATA_DIRS = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:/usr/share";
    BROWSER = "zen";
    EDITOR = "nano";
    TERMINAL = "kitty";
  };

  #Window Manager Environment
  hyprland.enable = true;
  niri.enable = true; # Niri Window Manager
  #gnome.enable = true;
  dunst.enable = true; # Notification Daemon
  waybar.enable = true; # Status Bar
  rofi-wayland.enable = true; # Application Launcher
  wlogout.enable = true; # Logout Utility

  x_cursor.enable = true; # Custom X Cursor
  rose-pine-cursor.enable = true; # Rose Pine Cursor Theme

  waypaper.enable = true; # Wallpaper Manager
  swww.enable = true; # Wallpaper Manager
  switchwall.enable = true; # Wallpaper Switcher

  # Stylix targets for Home Manager
  stylix.targets.foot.enable = true;

  # Enable/disable your custom modules here
  # gui Programs
  #gui_utils.enable = true;
  zen.enable = true;
  #brave.enable = true; # Web Browser

  vscode.enable = true; # Visual Studio Code - Code Editing
  nextcloud.enable = true; # Nextcloud Client
  easyeffects.enable = true;
  vesktop.enable = true;
  bitwarden.enable = true; # Password Manager
  
  loupe.enable = true; # Image viewer
  #yubikey.enable = true; # Security Key Support
  spicetify.enable = true; # Spotify Customization

  # cli Programs
  cli_utilities.enable = true; # CLI Utilities
  foot.enable = true; # Terminal Emulator
  power-profiles-daemon.enable = true; # Power Profiles Daemon | Used in Waybar
  playerctl.enable = true; # Media Player Control | Used in Waybar

  # Gaming Programs
  lutris.enable = true; # Game Manager
  wine.enable = true; # Compatibility Layer
  proton.enable = true; # Proton Addons
  gamescope.enable = true;
  #gamemode.enable = true; # Game Mode https://search.nixos.org/packages?channel=25.05&from=0&size=50&sort=relevance&type=packages&query=gamemode
  arrpc.enable = true; # Rich Presence for Vesktop


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
