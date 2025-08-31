# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use stable kernel for NVIDIA compatibility
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_6_15;

  networking.hostName = "nixos-desktop"; # Define your hostname.

  # User Configuration
  users.groups.tinus = {};

  users.users.tinus = {
    isNormalUser = true;
    description = "Tinus Braun";
    group = "tinus";
    extraGroups = [ "networkmanager" "wheel" "plugdev"];
    shell = pkgs.zsh;
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Console and Localization
  console.keyMap = "de-latin1-nodeadkeys";
  time.timeZone = "Europe/Berlin";
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

  # Enable Nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #=============================================================================#
  #                            SYSTEM CONFIGURATION                            #
  #=============================================================================#
  
  # Window Managers
  hyprland.enable = true;
  niri.enable = true;
  #bspwm.enable = true;

  # Display Manager
  sddm.enable = true;

  # Hardware Support
  nvidia.enable = true;

  # System Services
  libnotify.enable = true;
  wleave.enable = true;
  dunst.enable = true;
  system-programs.enable = true;

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
    "vulkan-loader"
    
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
    # Audio
    "pavucontrol"
    
    # System Tools
    "nwg-displays"
    "ark"
    
    # Browsers
    "zen-browser"
  ];
  nixos-apps-gui.extraPackages = [
  ];

  #=============================================================================#
  #                              CLI PROGRAMS                                  #
  #=============================================================================#
  nixos-apps-cli.enable = [
    # Version Control & Network
    "git"
    "curl"
    "wget"
    "openssh"
    "nmap"
    "tcpdump"
    "wireshark-cli"
    
    # Text Editors
    "vim"
    "nano"
    
    # System Monitoring
    "htop"
    "btop"
    "iotop"
    "iftop"
    "sysstat"
    "lm_sensors"
    "nvtop"
    
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
    "ethtool"
    "pciutils"
    "usbutils"
    
    # Text Processing
    "gnused"
    "gawk"
    "libxml2"
    
    # Security
    "gnupg"
  ];
  nixos-apps-cli.extraPackages = [
    pkgs.webkitgtk_4_1
    pkgs.betterdiscordctl
  ];

  #=============================================================================#
  #                            GAMING PROGRAMS                                 #
  #=============================================================================#
  nixos-apps-gaming.enable = [
    # Steam Tools
    "adwsteamgtk"
    
    # Game Downloaders
    "cirno-downloader"
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
    # Communication
    "thunderbird"
    "libreoffice"
    
    # System Authentication
    "lxqt-sudo"
    "polkit-gnome"
  ];
  nixos-apps-work.extraPackages = [
  ];
  



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
