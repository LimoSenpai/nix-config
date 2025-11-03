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
  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "nixos-desktop"; # Define your hostname.

  # User Configuration
  users.groups = {
    tinus = {};
    plugdev = {};
    media = {
      gid = 1500;
    };
  };

  users.users.tinus = {
    isNormalUser = true;
    description = "Tinus Braun";
    group = "tinus";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "media" ];
    shell = pkgs.zsh;
  };



  # WoL service now under `config`

  systemd.services."wol-enp12s0" = {
    description = "Enable Wake-on-LAN on enp12s0";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.ethtool}/sbin/ethtool -s enp12s0 wol g";
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 11434 7860 ];
    # optional: restrict to LAN only
    extraCommands = ''
      iptables -A nixos-fw -p tcp --dport 11434 -s 192.168.1.0/24 -j nixos-fw-accept
      iptables -A nixos-fw -p tcp --dport 7860 -s 192.168.1.0/24 -j nixos-fw-accept
    '';
  };
  # Ensure the md0 JBOD array is assembled before mounts run.
  systemd.services."mdadm-assemble-jbod" = {
    description = "Assemble md0 JBOD array";
    wantedBy = [ "local-fs.target" ];
    before = [ "mnt-jbod.mount" ];
    after = [ "systemd-udev-settle.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.writeShellScript "mdadm-assemble-jbod" ''
        set -eu
        ${pkgs.mdadm}/bin/mdadm --assemble --scan || true
        if [ -e /dev/md0 ]; then
          ${pkgs.mdadm}/bin/mdadm --manage /dev/md0 --run || true
        fi
      ''}";
    };
  };


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

  # Enable Nix features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowBroken = true;

  #=============================================================================#
  #                            SYSTEM CONFIGURATION                            #
  #=============================================================================#
  
  # Window Managers
  hyprland.enable = true;
  #niri.enable = true;
  #gnome.enable = true;
  #bspwm.enable = true;

  # Display Manager
  # In your host config:
  sddm.enable = true;

  noctalia.enable = true;

  # Hardware Support
  nvidia.enable = true;

  # System Services
  libnotify.enable = true;
  wleave.enable = true;
  dunst.enable = true;
  system-programs.enable = true;
  nixos-services.enable = lib.mkAfter [
    "stable-diffusion-webui"
    "ollama"
  ];
  

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
    #"mesa"
    "vulkan-loader"
    
    # System libraries
    "systemd"
    "dbus"

    #Networking essentials
    "ethtool"
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
    #"nwg-displays" #broken in unstable branch 25.11
    #"way-displays"
    "ark"
  ];
  nixos-apps-gui.extraPackages = [
    pkgs.wdisplays
    pkgs.firefox
    pkgs.linuxKernel.packages.linux_zen.ryzen-smu
    pkgs.ryzen-monitor-ng
    pkgs.bottles
  ];

  #=============================================================================#
  #                              CLI PROGRAMS                                  #
  #=============================================================================#
  nixos-apps-cli.enable = [
    # Network Tools requiring root
    "nmap"
    "tcpdump"
    #"wireshark-cli"
    
    # System monitoring requiring system access
    "lm_sensors"
    "ethtool"
    "pciutils"
    "usbutils"
    #"nvtop"
  ];
  nixos-apps-cli.extraPackages = [
    pkgs.webkitgtk_4_1
    pkgs.betterdiscordctl
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
    #"krb5"
    #"keyutils"
    "cifs-utils"
    #"lxqt-sudo"  # Temporarily disabled due to Qt6 build issues
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
