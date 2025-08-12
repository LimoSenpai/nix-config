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

  networking.hostName = "nixos-thinkcentre"; # Define your hostname.

  environment.variables = {
        http_proxy = "http://www-proxy1.uni-marburg.de:3128";
        https_proxy = "http://www-proxy1.uni-marburg.de:3128";
  };

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

  # System configuration
  #bspwm.enable = true; # Enable BSPWM, a tiling window manager
  hyprland.enable = true;
  niri.enable = true; # Enable Niri, a Wayland compositor

  sddm.enable = true; # Enable SDDM, a display manager

  libnotify.enable = true; # Enable libnotify for notifications
  wleave.enable = true; # Enable Wleave for window management
  dunst.enable = true; # Enable Dunst for notifications

  system-programs.enable = true; # Enable system programs
  standard-apps.enable = true; # Enable standard applications

  nvidia.enable = true; # Enable NVIDIA GPU support
  amd-radeon.enable = false; # Enable AMD Radeon GPU support

  # Programs Gui
  steam.enable = true; # Enable Steam for gaming
  cirno.enable = true; # Enable Cirno Downloader for games
  nwg-displays.enable = true; # Display Management
  pavucontrol.enable = true; # PulseAudio Volume Control

  # Programs Cli
  cirno_deps.enable = true; # Enable Cirno Dependencies
  



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
