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


### GUI APPS ###
  home-apps-gui.enable = [
    "vesktop"
    "bitwarden"
    "easyeffects"
    "obsidian"
    "brave"
    "loupe"
    "nextcloud"
    "vscode"
    "yubikey"
    #"discord"
    "pcmanfm"
    "swaynotificationcenter"
  ];
  home-apps-gui.extraPackages = [ 
  ];

  ### CLI APPS ###
  home-apps-cli.enable = [
    "fastfetch"
    "yazi"
    "grimblast"
    "mdadm"
    "jq"
    "hyperfine"
    "icu"
    "tmux"
  ];
  home-apps-cli.extraPackages = [ 
  ];
  
  ### GAMING APPS ###
  home-apps-gaming.enable = [
    "arrpc"
    "gamemode"
    "gamescope"
    "lutris"
    "protontricks"
    "protonplus"
    "wine"
    "winetricks"
    "prismlauncher"
  ];
  home-apps-gaming.extraPackages = [
  ];

  # Window Manager Environment
  hyprland.enable = true;
  niri.enable = false; # Niri Window Manager
  dunst.enable = true; # Notification Daemon
  waybar.enable = true; # Status Bar
  rofi-wayland.enable = true; # Application Launcher
  wofi.enable = true; # Application Launcher
  wlogout.enable = true; # Logout Utility

  #x_cursor.enable = true; # Custom X Cursor
  cursor.enable = true; # Rose Pine Cursor Theme

  waypaper.enable = true; # Wallpaper Manager
  swww.enable = true; # Wallpaper Manager
  switchwall.enable = true; # Wallpaper Switcher

  # Stylix targets for Home Manager
  stylix.targets.foot.enable = true;

  # Enable/disable your custom modules here
  # gui Programs
  zen-sine.enable = true;
  zen-sine.profilePath = ".zen/fbzuf3jk.Default Profile";
  spicetify.enable = true; # Spotify Customization

  # cli Programs
  foot.enable = true; # Terminal Emulator
  power-profiles-daemon.enable = true; # Power Profiles Daemon | Used in Waybar
  playerctl.enable = true; # Media Player Control | Used in Waybar


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
