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
  cursor.enable = true; # Future Cursor Theme

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
    # Browsers
    "zen-browser"
    "firefox"
    "chromium"
    
    # Communication
    "vesktop"
    "discord"
    "element-desktop"
    
    # Office & Productivity
    "obsidian"
    "vscode"
    "joplin"
    "kate"
    "libreoffice"
    
    # Media
    "vlc"
    "mpv"
    "loupe"
    
    # Graphics
    "gimp"
    "inkscape"
    
    # Cloud Storage
    "nextcloud"
    
    # Security
    "bitwarden"
    "yubikey"
    "ausweisapp"
    
    # Audio
    "easyeffects"
    "swaynotificationcenter"
    
    # File Management
    "pcmanfm"
    "ark"

    # Screenshot annotations
    "satty"
  ];
  home-apps-gui.extraPackages = [ 
    pkgs.betterdiscordctl
    pkgs.networkmanagerapplet
  ];

  #=============================================================================#
  #                              CLI PROGRAMS                                  #
  #=============================================================================#
  home-apps-cli.enable = [
    # Version Control & Network (user-level)
    "git"
    "curl"
    "wget"
    "openssh"
    
    # Text Editors
    "vim"
    "nano"
    
    # System Monitoring (user-level)
    "htop"
    "btop"
    "iotop"
    "iftop"
    "sysstat"
    
    # File Management
    "tree"
    "eza"
    "fzf"
    "rsync"
    
    # Archive Tools
    "unzip"
    "zip"
    "xz"
    "p7zip"
    "gnutar"
    "zstd"
    
    # Development Tools
    "gcc"
    "gnumake"
    
    # System Tools
    "killall"
    "lsof"
    "strace"
    "file"
    "which"
    "evtest"
    
    # Text Processing
    "gnused"
    "gawk"
    "libxml2"
    
    # Security
    "gnupg"
    
    # System Information
    "fastfetch"
    "lshw"
    
    # File Management
    "yazi"
    
    # Screenshot Tools
    "slurp"
    "grim"
    
    # System Tools
    "mdadm"
    "tmux"
    
    # Text Processing
    "jq"
    "icu"
    
    # Performance Tools
    "hyperfine"
    
    # Search
    "rg"
    
    # Document conversion
    "pandoc"
  ];
  home-apps-cli.extraPackages = [ 
    pkgs.mdadm
  ];

  #=============================================================================#
  #                            GAMING PROGRAMS                                 #
  #=============================================================================#
  home-apps-gaming.enable = [
    # Gaming Platforms
    "lutris"
    "heroic"
    
    # Gaming Tools
    "gamescope"
    "mangohud"
    
    # Emulators
    "retroarch"
    
    # Minecraft
    "prismlauncher"
    
    # Custom packages
    "cirno-downloader"
    
    # Discord Rich Presence
    "arrpc"
    
    # Game Tools
    "protontricks"
    "protonplus"
    
    # Wine
    "wine"
    "winetricks"
  ];
  home-apps-gaming.extraPackages = [
  ];

  #=============================================================================#
  #                              WORK PROGRAMS                                 #
  #=============================================================================#
  home-apps-work.enable = [
    # Communication
    "thunderbird"
    "element"
    
    # Security
    "keepass"
    
    # Office
    "libreoffice"
    "onenote"
    
    # Network/Authentication (user-level)
    "geteduroam"
  ];
  home-apps-work.extraPackages = [
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
  home.stateVersion = "25.11";
}
