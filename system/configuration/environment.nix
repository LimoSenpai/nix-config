
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Systemwide Installed Packages
    
    git
    nano
    wget
    pavucontrol
    nwg-displays
    bluez
    gsettings-desktop-schemas
    glib
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
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish; # Set fish as the default shell
  };

  # Program options
  programs = {
    fish = {
      enable = true;
      shellAliases = {
        ls = "eza";
      };
      interactiveShellInit = ''
        set -g fish_greeting ""
        neofetch
        if type -q starship
          starship init fish | source
        end
      '';
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
  services.power-profiles-daemon.enable = true;
  services.blueman.enable = true; # Optional, for GUI
  services.dbus.packages = [ pkgs.blueman ];

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

  #hardware 
  hardware.bluetooth.enable = true;
  hardware.graphics.enable32Bit = true;
}