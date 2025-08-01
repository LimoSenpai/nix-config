# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  
  # latest kernel patches
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixosMBP"; # Define your hostname.

<<<<<<< HEAD
   users.groups.tinus = {};

=======
  users.groups.tinus = {};
  
>>>>>>> f81ddbdc4e7814e579cf16594fd340abf7bb4ac4
  users.users.tinus = {
    isNormalUser = true;
    description = "Tinus Braun";
    group = "tinus";
    extraGroups = [ "networkmanager" "wheel" "plugdev"];
    shell = pkgs.zsh;
  };

  # Enable networking
  networking.networkmanager = {
     enable = true;
     wifi.backend = "wpa_supplicant";

  };
  # networking.wireless.iwd.enable = true;

  hardware.firmware = [
   (pkgs.stdenvNoCC.mkDerivation (final: {
      name = "brcm-firmware";
      src = ./firmware/brcm;
      installPhase = ''
        mkdir -p $out/lib/firmware/brcm
        cp ${final.src}/* $out/lib/firmware/brcm
     '';
     }))
   ];


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

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  nix.settings.experimental-features = [ "nix-command" "flakes" ];



  ## NixOS module options ##

  ## Window Managers
  gnome.enable = true; # Enable GNOME desktop environment
  #bspwm.enable = true; # Enable BSPWM, a tiling window manager
  #hyprland.enable = true;
  #nvidia.enable = true; # Enable NVIDIA GPU support
  #niri.enable = true; # Enable Niri, a Wayland compositor

<<<<<<< HEAD
  #sddm.enable = true; 
=======
  #sddm.enable = true; # Enable SDDM, a display manager
>>>>>>> f81ddbdc4e7814e579cf16594fd340abf7bb4ac4

  #libnotify.enable = true; # Enable libnotify for notifications
  #wleave.enable = true; # Enable Wleave for window management
  #dunst.enable = true; # Enable Dunst for notifications

  ## Programs Gui
  nwg-displays.enable = true; # Display Management
  pavucontrol.enable = true; # PulseAudio Volume Control

  ## Programs Cli
  cli_utilities.enable = true; # Enable CLI Utilities
  # cirno_deps.enable = true; # Enable Cirno Dependencies



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
