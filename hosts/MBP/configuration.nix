# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  #services.xserver.videoDrivers = [ "intel" "amdgpu" ];
  
  # latest kernel patches
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixosMBP"; # Define your hostname.


  users.groups.tinus = {};
  
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
  networking.wg-quick.interfaces.wg0 = {
    configFile = "/etc/wireguard/wg_config.conf"; 
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

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.xserver = {
    enable = true;
    xkb.options = "altwin:swap_lalt_lwin"; # Swap left Alt and left Super
  };

  ## NixOS module options ##

  # System configuration
  #gnome.enable = true; # Enable GNOME desktop environment
  #kde6.enable = true; # Enable KDE Plasma 6 desktop environment
  #bspwm.enable = true; # Enable BSPWM, a tiling window manager
  hyprland.enable = true;
  sway.enable = true; # Enable Sway, a Wayland compositor
  #nvidia.enable = true; # Enable NVIDIA GPU support
  niri.enable = true; # Enable Niri, a Wayland compositor

  sddm.enable = true; 

  libnotify.enable = true; # Enable libnotify for notifications
  wleave.enable = true; # Enable Wleave for window management
  dunst.enable = true; # Enable Dunst for notifications

  system-programs.enable = true; # Enable system programs
  standard-apps.enable = true; # Enable standard applications

  amd-radeon.enable = false; # Enable AMD Radeon GPU support

  ## Programs Gui
  steam.enable = true; # Enable Steam for gaming
  mbp_touchbar.enable = true; # Enable MacBook Pro Touch Bar support
  nwg-displays.enable = true; # Display Management
  pavucontrol.enable = true; # PulseAudio Volume Control

  ## Programs Cli
  # cirno_deps.enable = true; # Enable Cirno Dependencies



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
