{ lib, pkgs, config, inputs, ... }:
let
  # Central registry: name -> package
  registry = with pkgs; {
    # Browsers
    firefox            = firefox;
    zen-browser        = inputs.zen-browser.packages.${pkgs.system}.default;
    chromium           = ungoogled-chromium;
    
    # Communication
    vesktop            = vesktop;
    discord            = discord;
    thunderbird        = thunderbird;
    element-desktop    = element-desktop;
    teams              = teams-for-linux;
    goofcord           = goofcord;
    
    # Office & Productivity
    obsidian           = obsidian;
    vscode             = vscode-fhs;
    joplin             = joplin-desktop;
    kate               = kdePackages.kate;
    libreoffice        = libreoffice;
    office             = libreoffice-qt-still;
    
    # Media
    vlc                = vlc;
    mpv                = mpv;
    loupe              = loupe;
    
    # Graphics
    gimp               = gimp;
    inkscape           = inkscape;
    
    # Cloud Storage
    nextcloud          = nextcloud-client;
    
    # Security
    bitwarden          = bitwarden-desktop;
    yubikey            = yubioath-flutter;
    ausweisapp         = ausweisapp;
    swaylock-fancy     = swaylock-fancy;
    
    # Audio
    easyeffects        = easyeffects;
    swaynotificationcenter = swaynotificationcenter;
    pavucontrol        = pavucontrol;
    pulseaudio         = pulseaudio;
    
    # File Management
    pcmanfm            = pcmanfm;
    ark                = file-roller; # Archive manager (GNOME-based instead of KDE)
    
    # Screenshot Tools
    satty              = satty;
    
    # System Tools
    nwg-displays       = nwg-displays;
    way-displays       = way-displays;
    hyprlock           = hyprlock;
  };

  validNames = builtins.attrNames registry;
  cfg = config.home-apps-gui;
in
{
  options.home-apps-gui = {
    enable = lib.mkOption {
      type = lib.types.listOf (lib.types.enum validNames);
      default = [];
      example = [ "vesktop" "keepassxc" ];
      description = "List of registry apps to install.";
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Arbitrary extra packages not in the registry.";
    };
  };

  options = {
    obs-studio.enable = lib.mkEnableOption "OBS Studio screen recording and streaming";
  };

  config = {
    home.packages =
      (map (name: registry.${name}) cfg.enable)
      ++ cfg.extraPackages;

    programs.obs-studio = lib.mkIf config.obs-studio.enable {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
      ];
    };
  };
}
