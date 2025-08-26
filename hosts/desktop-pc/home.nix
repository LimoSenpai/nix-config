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
  niri.enable = false;

  # Window Manager Utilities
  dunst.enable = true;
  wleave.enable = true;
  rofi-wayland.enable = true;
  wofi.enable = true;
  waybar.enable = true;

  # Cursor & Theming
  cursor.enable = true; # Bibata Cursor Theme

  # Wallpaper Management
  waypaper.enable = true;
  swww.enable = true;
  switchwall.enable = true; 

  #=============================================================================#
  #                           ADDITIONAL PROGRAMS                              #
  #=============================================================================#
  
  # GUI Programs
  spicetify.enable = true; # Spotify Customization
  obs-studio.enable = true;

  # CLI Programs
  # foot.enable = true; # Terminal Emulator (disabled due to SSH issues)
  power-profiles-daemon.enable = true; # Power Profiles Daemon | Used in Waybar
  playerctl.enable = true; # Media Player Control | Used in Waybar
  alacritty.enable = true;
  git.enable = true;

  #=============================================================================#
  #                              GUI PROGRAMS                                  #
  #=============================================================================#
  home-apps-gui.enable = [
    # Communication
    "vesktop"
    "discord"
    
    # Office & Productivity
    "obsidian"
    "vscode"
    "joplin"
    "kate"
    
    # Media
    "loupe"
    
    # Cloud Storage
    "nextcloud"
    
    # Security
    "bitwarden"
    "yubikey"
    
    # Audio
    "easyeffects"
    "swaynotificationcenter"
    
    # File Management
    "pcmanfm"
    
    # Browsers (commented)
    #"brave"
    #"goofcord"
  ];
  home-apps-gui.extraPackages = [ 
    pkgs.betterdiscordctl
    pkgs.networkmanagerapplet
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
  ];

  #=============================================================================#
  #                            GAMING PROGRAMS                                 #
  #=============================================================================#
  home-apps-gaming.enable = [
    # Discord Rich Presence
    "arrpc"
    
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
  ];
  home-apps-gaming.extraPackages = [
  ];

  # Stylix Configuration
  # stylix.targets.foot.enable = true;


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
