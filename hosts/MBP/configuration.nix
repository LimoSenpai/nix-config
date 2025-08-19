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

  ### SYSTEM CONFIGURATION ###
  # Desktop Environments
  #gnome.enable = true; # Enable GNOME desktop environment
  #kde6.enable = true; # Enable KDE Plasma 6 desktop environment

  # Window Managers
  #bspwm.enable = true; # Enable BSPWM, a tiling window manager
  hyprland.enable = true;
  sway.enable = true; # Enable Sway, a Wayland compositor
  niri.enable = true; # Enable Niri, a Wayland compositor

  # Display Manager
  sddm.enable = true; 

  # System Services
  libnotify.enable = true; # Enable libnotify for notifications
  wleave.enable = true; # Enable Wleave for window management
  dunst.enable = true; # Enable Dunst for notifications
  system-programs.enable = true; # Enable system programs
  standard-apps.enable = true; # Enable standard applications

  # Hardware Support
  #nvidia.enable = true; # Enable NVIDIA GPU support
  amd-radeon.enable = false; # Enable AMD Radeon GPU support

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
    "tiny-dfr"
  ];
  nixos-apps-cli.extraPackages = [
    # Add extra CLI packages here
  ];

  ### GAMING APPS ###
  nixos-apps-gaming.enable = [
    "steam"
    "adwsteamgtk"
  ];
  nixos-apps-gaming.extraPackages = [
    # Add extra gaming packages here
  ];

  ### WORK APPS ###
  nixos-apps-work.enable = [
    # Add your work apps here
  ];
  nixos-apps-work.extraPackages = [
    # Add extra work packages here
  ];

  # Individual modules (legacy - specialized configurations)
  # mbp_touchbar.enable = true; # Migrated to tiny-dfr in CLI registry above



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
