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
  alacritty.enable = true;
  git.enable = true;

  # GUI Programs
  spicetify.enable = true; # Spotify Customization

  #=============================================================================#
  #                              GUI PROGRAMS                                  #
  #=============================================================================#
  home-apps-gui.enable = [
    # Communication
    "discord"
    "teams"
    
    # Office & Productivity
    "obsidian"
    "vscode"
    "joplin"
    
    # Media
    "loupe"
    
    # Cloud Storage
    "nextcloud"
    
    # Security
    "bitwarden"
    "swaylock-fancy"
    
    # Audio & Notifications
    "swaynotificationcenter"
    
    # File Management
    "pcmanfm"
    
    # Browsers
    #"brave"
    
    # Hardware & Communication (commented)
    #"vesktop"
    #"easyeffects"
    #"yubikey"
  ];
  home-apps-gui.extraPackages = [
    pkgs.yubioath-flutter
  ];

  #=============================================================================#
  #                              CLI PROGRAMS                                  #
  #=============================================================================#
  home-apps-cli.enable = [
    # System Information
    "fastfetch"
    
    # File Management
    "yazi"
    
    # Screenshot Tools
    "grimblast"
    
    # System Tools
    "mdadm"
    "tmux"
    
    # Text Processing
    "jq"
    "icu"
    
    # Performance Tools
    "hyperfine"
  ];
  home-apps-cli.extraPackages = [
    pkgs.wireguard-tools
    pkgs.traceroute
    pkgs.networkmanagerapplet
  ];

  #=============================================================================#
  #                            GAMING PROGRAMS                                 #
  #=============================================================================#
  home-apps-gaming.enable = [
    # Game Launchers
    "lutris"
    "prismlauncher"
    
    # Game Tools
    "gamescope"
    "protontricks"
    "protonplus"
    
    # Wine
    "wine"
    "winetricks"
    
    # Discord Rich Presence (commented)
    #"arrpc"
  ];
  home-apps-gaming.extraPackages = [
  ];


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
