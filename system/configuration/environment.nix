
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Systemwide Installed Packages
    
    git
    nano
    wget
    foot
    pavucontrol
    nwg-displays
    bluez
    bitwarden-desktop
    vscode-fhs
    nextcloud-client
    obsidian
    glib
    brave

    # Root Authentication
    lxqt.lxqt-sudo
    polkit_gnome



    # Default Applications
    gsettings-desktop-schemas
    man-db

    # theme
    rose-pine-hyprcursor
    gruvbox-plus-icons
    hicolor-icon-theme

    #cirno
    libxml2
    webkitgtk_4_1
    p7zip
  ];
  
  # User Settings
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tinus = {
    isNormalUser = true;
    description = "Tinus Braun";
    extraGroups = [ "networkmanager" "wheel" "plugdev"];
    shell = pkgs.zsh;
  };

  # Program options
  programs = {
    
    coolercontrol = {
      enable =  true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    
    foot = {
      enable = true;
      enableZshIntegration = true;
    };
    
    zsh = {
      enable = true;
      shellAliases = {
        ls = "eza";
        cp = "cp -i";
        mv = "mv -i";
        rm = "rm -i";
      };
      interactiveShellInit = ''
        fastfetch
        if command -v starship >/dev/null 2>&1; then
          eval "$(starship init zsh)"
        fi
      '';
    };

    #fish = {
    #  enable = true;
    #  shellAliases = {
    #    ls = "eza";
    #  };
    #  interactiveShellInit = ''
    #    set -g fish_greeting ""
    #    fastfetch
    #    if type -q starship
    #      starship init fish | source
    #    end
    #  '';
    #};

    bat = {
      enable = true;
    };
    # starship - an customizable prompt for any shell
    starship = {
      enable = true;
      # custom settings
      settings = {
        add_newline = false;
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = true;
      };
      presets = [
        "nerd-font-symbols"
      ];
    };

    # idk was for Cirno I think
    nix-ld = {
      enable = true;
    };
    gdk-pixbuf = {
      modulePackages = [ pkgs.librsvg ];
    };
  };

  systemd.user.services.lxqt-policykit = {
    description = "PolicyKit Authentication Agent";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.lxqt.lxqt-policykit}/libexec/lxqt-policykit-agent";
      Restart = "on-failure";
    };
  };


  # Environment Settings
  environment.variables = {
    XCURSOR_THEME = "BreezeX-RosePine";
    XCURSOR_SIZE = 26;
    HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    HYPRCURSOR_SIZE = 26;
    NIXOS_OZONE = "1"; # Enable Ozone for Hyprland
  };
  
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        .zen-wrapped
      ''; 
      mode = "0755";
    };
  };

  # services

  services.udev.extraRules = ''
    # SteelSeries Aerox 9 Wireless — Allow USB and hidraw access
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1038", MODE="0666"
    KERNEL=="hidraw*", ATTRS{idVendor}=="1038", MODE="0666"
  '';



  services.power-profiles-daemon.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.blueman.enable = true;
  services.dbus.packages = [ 
    pkgs.blueman 
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };

  # Security
  # security.polkit.enable = true;

  # Hardware
  hardware.bluetooth.enable = true;
  hardware.graphics.enable32Bit = true;
}