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
  boot.kernelPackages = pkgs.linuxPackages_6_16;

  # User Settings
  users.groups.tinus = {};

  users.users.tinus = {
    isNormalUser = true;
    description = "Tinus Braun";
    group = "tinus";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "ad-cifs" ];
    shell = pkgs.zsh;
  };

  users.groups.tinus = {};

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "nixos-thinkcentre";

    # Default gateway via eno1
    /*
    defaultGateway = {
      address   = "192.168.113.250";
      interface = "eno1";
    };
    */

    ### PROXY SETTINGS ### 
    proxy = { 
      default = "http://www-proxy1.uni-marburg.de:3128/"; 
      httpProxy = "http://www-proxy1.uni-marburg.de:3128"; 
      httpsProxy = "http://www-proxy1.uni-marburg.de:3128"; 
      noProxy = "127.0.0.1,localhost,::1,.local,192.168.0.0/16,10.0.0.0/8,192.168.178.0/24";
    };

    /*
    networkmanager.ensureProfiles.profiles = {
      "lan-default" = {
        connection = {
          id = "lan-default";
          type = "ethernet";
          interface-name = "eno1";
          autoconnect = true;
        };
        ipv4 = {
          method = "auto";
          route-metric = 100;
        };
        ipv6.method = "auto";
      };
    };
    */

    wg-quick.interfaces.wg0 = {
      configFile = "/etc/wireguard/wg_config.conf"; 
      /*
      preUp = ''
      #  ${pkgs.iproute2}/bin/ip route replace 89.246.51.89/32 via 10.193.63.250 dev wlp2s0
      #'';
      #postDown = ''
      #  ${pkgs.iproute2}/bin/ip route del 89.246.51.89/32 dev wlp2s0 || true
      '';
      */
    };
  };

  /*
  networking.networkmanager.dispatcherScripts = [
    {
      source = pkgs.writeShellScript "wg-endpoint-route" ''
        IFACE="$1"; STATE="$2"
        if [ "$IFACE" = "wlp2s0" ]; then
          case "$STATE" in
            up|vpn-up)
              ${pkgs.iproute2}/bin/ip route replace 89.246.51.89/32 via 10.193.63.250 dev wlp2s0
              ;;
            down|vpn-down)
              ${pkgs.iproute2}/bin/ip route del 89.246.51.89/32 dev wlp2s0 || true
              ;;
          esac
        fi
      '';
    }
  ];
  */

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";
  # Set your time zone.
  time.timeZone = lib.mkDefault "Europe/Berlin";
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

  ### System configuration ###
  #bspwm.enable = true; # Enable BSPWM, a tiling window manager
  hyprland.enable = true;
  #niri.enable = true; # Enable Niri, a Wayland compositor

  sddm.enable = true; # Enable SDDM, a display manager
  #hyprlock.enable = true;

  libnotify.enable = true; # Enable libnotify for notifications
  wleave.enable = true; # Enable Wleave for window management
  #dunst.enable = true; # Enable Dunst for notifications

  system-programs.enable = true; # Enable system programs
  standard-apps.enable = true; # Enable standard applications
  #zen.enable = true; # Enable Zen Browser, a Firefox-based web browser

  #nvidia.enable = true; # Enable NVIDIA GPU support
  #amd-radeon.enable = false; # Enable AMD Radeon GPU support

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
    "thunderbird-bin"
    "keepassxc"
    "libreoffice-qt-still"
    "krb5"
    "cifs-utils"
    "keyutils"
    "element-desktop"
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
