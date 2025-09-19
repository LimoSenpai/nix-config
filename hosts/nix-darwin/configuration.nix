{ config, lib, pkgs, ... }:

{
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim
    git
    coreutils
  ];

  # Auto upgrade nix package  # This value determines the nix-darwin release with which your system is to be compatible
  # Do not change this value after initial setup.
  system.stateVersion = 6;
  services.nix-daemon.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Set your system hostname
  networking.hostName = "mbp-darwin";  

  # Console and Localization
  console.keyMap = "de-latin1-nodeadkeys";
  time.timeZone = lib.mkDefault "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System settings
  system = {
    # Configure keyboard
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;  # Optional: remap caps lock to escape
    };
    
    # Configure defaults
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "WhenScrolling";
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
      };

      dock = {
        autohide = true;
        orientation = "bottom";
        showhidden = true;
        tilesize = 40;
      };

      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
        FXEnableExtensionChangeWarning = false;
      };
    };
  };

  #=============================================================================#
  #                          SYSTEM ESSENTIAL PACKAGES                         #
  #=============================================================================#
  nixos-system-essentials.enable = [
    # Core system libraries
    "bluez"
    "glib"
    
    # Themes and icons
    "hicolor-icon-theme"
    "adwaita-icon-theme" 
    "gsettings-desktop-schemas"
    
    # Documentation
    "man-db"
    "man-pages"
    
    # Core utilities
    "coreutils"
    "util-linux"
    "findutils"
    
    # Audio libraries
    "alsa-lib"
    "alsa-utils"
    "pipewire"
    
    # Graphics libraries
    "mesa"
    
    # System libraries
    "systemd"
    "dbus"
  ];
  nixos-system-essentials.extraPackages = [ 
  ];

  #=============================================================================#
  #                              GUI PROGRAMS                                  #
  #=============================================================================#
  nixos-apps-gui.enable = [
    # System audio (if needed system-wide)
    "pavucontrol"
    
    # System Tools requiring system access
    "hyprlock"
    "ark"
  ];
  nixos-apps-gui.extraPackages = [
    pkgs.wdisplays
  ];

  #=============================================================================#
  #                              CLI PROGRAMS                                  #
  #=============================================================================#
  nixos-apps-cli.enable = [
    # Network Tools requiring root
    "nmap"
    "tcpdump"
    "wireshark-cli"
    "netbird"
    
    # System monitoring requiring system access
    "lm_sensors"
    "ethtool"
    "pciutils"
    "usbutils"
    "nvtop"
  ];
  nixos-apps-cli.extraPackages = [
    pkgs.dig
  ];

  #=============================================================================#
  #                            GAMING PROGRAMS                                 #
  #=============================================================================#
  nixos-apps-gaming.enable = [
    # Steam Tools requiring system configuration
    "adwsteamgtk"
    "protontricks"
  ];
  nixos-apps-gaming.extraPackages = [
  ];
  
  # Gaming Options
  steam.enable = true;
  gamemode.enable = true;

  #=============================================================================#
  #                              WORK PROGRAMS                                 #
  #=============================================================================#
  nixos-apps-work.enable = [
    # System authentication tools
    "krb5"
    "keyutils"
    "cifs-utils"
    "lxqt-sudo"
    "polkit-gnome"
  ];
  nixos-apps-work.extraPackages = [
  ];

}
