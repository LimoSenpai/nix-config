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
  

  #=============================================================================#
  #                            SYSTEM CONFIGURATION                            #
  #=============================================================================#
  
  # Desktop Environments
  #gnome.enable = true; # Enable GNOME desktop environment
  #kde6.enable = true; # Enable KDE Plasma 6 desktop environment

  # Window Managers
  hyprland.enable = true;
  gnome.enable = true;
  #sway.enable = true; # Enable Sway, a Wayland compositor
  niri.enable = true; # Enable Niri, a Wayland compositor
  #bspwm.enable = true; # Enable BSPWM, a tiling window manager

  # Display Manager
  sddm.enable = true; 

  # Hardware Support
  #nvidia.enable = true; # Enable NVIDIA GPU support
  #amd-radeon.enable = false; # Enable AMD Radeon GPU support

  # System Services
  libnotify.enable = true; # Enable libnotify for notifications
  wleave.enable = true; # Enable Wleave for window management
  dunst.enable = true; # Enable Dunst for notifications
  system-programs.enable = true; # Enable system programs

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
    # Browsers
    "zen-browser"

    # SYSTEM TOOLS
    "pavucontrol"
    
    # System Tools

    # AMD
    "mesa-demos"
    "radeon-profile"
  ];
  nixos-apps-gui.extraPackages = [
    pkgs.wdisplays
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
    
    # Hardware specific (MacBook)
    "tiny-dfr"
  ];
  nixos-apps-cli.extraPackages = [
  ];

  #=============================================================================#
  #                            GAMING PROGRAMS                                 #
  #=============================================================================#
  nixos-apps-gaming.enable = [
    # Steam Tools
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
    # Communication
    "thunderbird"
    "element"
    
    # Office
    "libreoffice"
    "onenote"
    
    # Security & Authentication
    "keepass"
    "krb5"
    "keyutils"
    "cifs-utils"
    "geteduroam"
    "lxqt-sudo"
    "polkit-gnome"
  ];
  nixos-apps-work.extraPackages = [
    pkgs.qalculate-gtk
    pkgs.speedcrunch
  ];
  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
