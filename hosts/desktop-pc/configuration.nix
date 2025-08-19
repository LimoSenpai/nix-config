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

  # User Settings
  users.groups.tinus = {};

  users.users.tinus = {
    isNormalUser = true;
    description = "Tinus Braun";
    group = "tinus";
    extraGroups = [ "networkmanager" "wheel" "plugdev"];
    shell = pkgs.zsh;
  };

  users.groups.tinus = {};

  # Enable networking
  networking.networkmanager.enable = true;


  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";
  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  # Select internationalisation properties.
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


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ### SYSTEM CONFIGURATION ###
  # Window Managers
  #bspwm.enable = true; # Enable BSPWM, a tiling window manager
  hyprland.enable = true;
  niri.enable = true; # Enable Niri, a Wayland compositor

  # Display Manager
  sddm.enable = true; # Enable SDDM, a display manager

  # System Services
  libnotify.enable = true; # Enable libnotify for notifications
  wleave.enable = true; # Enable Wleave for window management
  dunst.enable = true; # Enable Dunst for notifications
  system-programs.enable = true; # Enable system programs
  standard-apps.enable = true; # Enable standard applications
  #zen.enable = true; # Enable Zen Browser, a Firefox-based web browser

  # Hardware Support
  nvidia.enable = true; # Enable NVIDIA GPU support

  ### GUI APPS ###
  nixos-apps-gui.enable = [
    "pavucontrol"
    "nwg-displays"
  ];
  nixos-apps-gui.extraPackages = [
    # Add extra GUI packages here
  ];

  ### CLI APPS ###
  nixos-apps-cli.enable = [
    "git"
    "curl"
    "htop"
    "vim"
    "libxml2"
    "p7zip"
  ];
  nixos-apps-cli.extraPackages = [
    pkgs.webkitgtk_4_1
  ];

  # Individual CLI modules (legacy - will be removed)
  # cirno_deps.enable = true; # Migrated to registry above

  ### GAMING APPS ###
  nixos-apps-gaming.enable = [
    "steam"
    "adwsteamgtk"
    "cirno-downloader"
  ];
  nixos-apps-gaming.extraPackages = [
    # Add extra gaming packages here
  ];

  # Individual Gaming modules (legacy - will be removed)
  # steam.enable = true; # Migrated to registry above
  # cirno.enable = true; # Migrated to registry above

  ### WORK APPS ###
  nixos-apps-work.enable = [
    # Add your work apps here
    "thunderbird"
  ];
  nixos-apps-work.extraPackages = [
    # Add extra work packages here
  ];
  



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
