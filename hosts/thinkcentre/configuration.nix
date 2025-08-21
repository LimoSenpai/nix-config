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
    extraGroups = [ "networkmanager" "wheel" "plugdev" "ad-cifs" ];
    shell = pkgs.zsh;
  };

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
  #nvidia.enable = true;
  #amd-radeon.enable = false;

  # System Services
  libnotify.enable = true;
  wleave.enable = true;
  #dunst.enable = true;
  system-programs.enable = true;
  system-essentials.enable = true;
  work_drive.enable = true; # Enable Work Group Drive

  #=============================================================================#
  #                              GUI PROGRAMS                                  #
  #=============================================================================#
  nixos-apps-gui.enable = [
    "zen-browser"

    #System Tools
    "pavucontrol"
    "nwg-displays"
    "hyprlock"
    "ark"
  ];
  nixos-apps-gui.extraPackages = [
  ];

  #=============================================================================#
  #                              CLI PROGRAMS                                  #
  #=============================================================================#
  nixos-apps-cli.enable = [
    "git"
    "curl"
    "wget"
    "vim"
    "nano"
    "htop"
    "btop"
    "tree"
    "unzip"
    "zip"
    "xz"
    "rsync"
    "openssh"
    "killall"
    "eza"
    "fzf"
    "gcc"
    "gnumake"
    "nmap"
    "tcpdump"
    "wireshark-cli"
    "lsof"
    "strace"
    "file"
    "which"
    "evtest"
    "iotop"
    "iftop"
    "sysstat"
    "lm_sensors"
    "ethtool"
    "pciutils"
    "usbutils"
    "p7zip"
    "gnutar"
    "zstd"
    "gnused"
    "gawk"
    "gnupg"
    "nvtop"
    "libxml2"
  ];
  nixos-apps-cli.extraPackages = [
  ];

  #=============================================================================#
  #                            GAMING PROGRAMS                                 #
  #=============================================================================#
  nixos-apps-gaming.enable = [
    "adwsteamgtk"
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
    "thunderbird"
    "element"
    "libreoffice"

    #Security
    "keepass"
    "krb5"
    "keyutils"
    "cifs-utils"
    "geteduroam"
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
  system.stateVersion = "25.05"; # Did you read the comment?

}
