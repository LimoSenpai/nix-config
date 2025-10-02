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
  boot.kernelPackages = pkgs.linuxPackages_6_16;

  # User Configuration
  users.groups.tinus = {};

  users.users.tinus = {
    isNormalUser = true;
    description = "Tinus Braun";
    group = "tinus";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "ad-cifs" "media" ];
    shell = pkgs.zsh;
  };

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "nixos-l490";
    #nameservers = [ "192.168.1.1" "137.248.1.8" ];

    ### PROXY SETTINGS ### 
    #proxy = { 
    #  default = "http://www-proxy1.uni-marburg.de:3128/"; 
    #  httpProxy = "http://www-proxy1.uni-marburg.de:3128"; 
    #  httpsProxy = "http://www-proxy1.uni-marburg.de:3128"; 
    #  noProxy = "127.0.0.1,localhost,::1,.local,192.168.0.0/16,10.0.0.0/8,192.168.178.0/24";
    #};

    wg-quick ={
      interfaces.wg2 = {
        configFile = "/etc/wireguard/wg2.conf"; 
      };
      #interfaces.wg2 = {
      #  configFile = "/etc/wireguard/wg2.conf"; 
      #};
    };
  };

    # optional but recommended if you later want split-DNS
    services.resolved.enable = true;

    #systemd.network.networks."10-eno1" = {
    #  matchConfig.Name = "eno1";
    #  networkConfig.DHCP = "yes";
    #  routes = [
    #    { Destination = "192.168.1.119/32"; Gateway = "137.248.113.250"; }
    #    { Destination = "192.168.16.40/32"; Gateway = "137.248.113.250"; }
    #    { Destination = "192.168.16.3/32";  Gateway = "137.248.113.250"; }
    #    { Destination = "137.248.21.22/32";  Gateway = "137.248.113.250"; }
    #  ];
    #};

    # pin hostnames (same as /etc/hosts)
    #networking.hosts = {
    #  "192.168.1.119" = [ "share.uni-marburg.de" ];
    #  "192.168.16.40" = [ "support.hrz.uni-marburg.de" ];
    #  "192.168.16.3"  = [ "ldap-master.hrz.uni-marburg.de" ];
    #};

/*
  systemd.network.networks."10-eno1" = {
    matchConfig.Name = "eno1";
    networkConfig.DHCP = "yes";

    routes = [
      { Destination = "192.168.1.119/32"; Gateway = "137.248.113.250"; GatewayOnLink = true; Metric = 50; }
      { Destination = "192.168.16.40/32"; Gateway = "137.248.113.250"; GatewayOnLink = true; Metric = 50; }
      { Destination = "192.168.16.3/32";  Gateway = "137.248.113.250"; GatewayOnLink = true; Metric = 50; }
      { Destination = "137.248.21.22/32"; Gateway = "137.248.113.250"; GatewayOnLink = true; Metric = 50; }
    ];

    # Make sure these go via main (before wg policy rules)
    routingPolicyRules = [
      { To = "192.168.1.119/32"; Table = "main"; Priority = 1000; }
      { To = "192.168.16.40/32"; Table = "main"; Priority = 1000; }
      { To = "192.168.16.3/32";  Table = "main"; Priority = 1000; }
      { To = "137.248.21.22/32"; Table = "main"; Priority = 1000; }
    ];
  };
*/

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

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 


  #=============================================================================#
  #                            SYSTEM CONFIGURATION                            #
  #=============================================================================#
  
  # Window Managers
  hyprland.enable = true;
  niri.enable = true; # Enable Niri, a Wayland compositor

  # Display Manager
  sddm.enable = true;

  wleave.enable = true;

  # Hardware Support
  #nvidia.enable = true;
  #amd-radeon.enable = false;

  # Software
  system-programs.enable = true; # Enable system programs
  work_drive.enable = true; # Enable work drive configuration

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

  



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
