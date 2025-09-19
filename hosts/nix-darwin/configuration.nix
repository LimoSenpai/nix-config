{ config, lib, pkgs, ... }:

{

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
  #                          SYSTEM PACKAGES                                  #
  #=============================================================================#
  environment.systemPackages = with pkgs; [
    # Core utilities
    coreutils
    findutils
    gnutar
    gzip
    wget
    curl
    git
    
    # System tools
    htop
    tree
    ripgrep
    fd
    
    # Development tools
    vim
    nano
    
    # Network tools
    nmap
    dig
    
    # macOS specific
    m-cli  # useful macOS CLI commands
    mas    # Mac App Store CLI
  ];

}
