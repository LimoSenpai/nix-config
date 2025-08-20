{ lib, pkgs, config, inputs, ... }:
let
  # Central registry: name -> package/configuration
  registry = with pkgs; {
    # Browsers
    firefox            = firefox;
    chromium           = chromium;
    zen-browser        = inputs.zen-browser.packages.${pkgs.system}.default;
    
    # Media
    vlc                = vlc;
    mpv                = mpv;
    
    # Graphics
    gimp               = gimp;
    inkscape           = inkscape;
    
    # Office
    libreoffice        = libreoffice;
    
    # Communication
    discord            = discord;
    element-desktop    = element-desktop;
    thunderbird        = thunderbird;
    
    # Development
    vscode             = vscode;
    
    # Audio
    pavucontrol        = pavucontrol;
    pulseaudio         = pulseaudio;
    
    # System Tools
    nwg-displays       = nwg-displays;
    hyprlock           = hyprlock;
    
    # AMD Tools
    mesa-demos         = mesa-demos;
    radeon-profile     = radeon-profile;
  };

  validNames = builtins.attrNames registry;
  cfg = config.nixos-apps-gui;
in
{
  options.nixos-apps-gui = {
    enable = lib.mkOption {
      type = lib.types.listOf (lib.types.enum validNames);
      default = [];
      example = [ "firefox" "discord" "pavucontrol" ];
      description = "List of registry GUI apps to install system-wide.";
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Arbitrary extra packages not in the registry.";
    };
  };

  config = lib.mkMerge [
    {
      environment.systemPackages = 
        (map (name: registry.${name}) cfg.enable) ++ cfg.extraPackages;
    }
    
    # Special configuration for pavucontrol (if needed)
    (lib.mkIf (builtins.elem "pavucontrol" cfg.enable) {
      # hardware.pulseaudio.enable = true; # Uncomment if needed
    })
  ];
}
