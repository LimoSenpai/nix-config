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
    TERMINAL = "alacritty";
  };


  #=============================================================================#
  #                              GUI PROGRAMS                                  #
  #=============================================================================#
  home-apps-gui.enable = [
    #"vesktop"
    "bitwarden"
    #"easyeffects"
    "obsidian"
    "brave"
    "loupe"
    "nextcloud"
    "vscode"
    #"yubikey"
    "discord"
    "pcmanfm"
    "swaylock-fancy"
    "swaynotificationcenter"
    "teams"
    "joplin"
  ];
  home-apps-gui.extraPackages = [
  ];

  #=============================================================================#
  #                              CLI PROGRAMS                                  #
  #=============================================================================#
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
    pkgs.wireguard-tools
    pkgs.traceroute
    pkgs.networkmanagerapplet
  ];

  # CLI program options
  alacritty.enable = true;
  git.enable = true;

  #=============================================================================#
  #                            GAMING PROGRAMS                                 #
  #=============================================================================#
  home-apps-gaming.enable = [
    #"arrpc"
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

  #=============================================================================#
  #                      WINDOW MANAGER ENVIRONMENT                            #
  #=============================================================================#

  hyprland.enable = true;
  niri.enable = false; # Niri Window Manager

  # Window Manager Utilities
  dunst.enable = true;
  waybar.enable = true;
  rofi-wayland.enable = true;
  wofi.enable = true;
  wleave.enable = true;
  hyprlock.enable = true;

  # Cursor & Theming
  cursor.enable = true; # Bibata Cursor Theme

  # Wallpaper Management
  waypaper.enable = true;
  swww.enable = true;
  switchwall.enable = true; 

  #=============================================================================#
  #                           ADDITIONAL PROGRAMS                              #
  #=============================================================================#
  
  # CLI Programs
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
