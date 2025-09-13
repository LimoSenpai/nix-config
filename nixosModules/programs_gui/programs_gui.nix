{ lib, pkgs, config, inputs, ... }:
let
  # Central registry: name -> package/configuration
  registry = with pkgs; {
    # System Tools (requiring system-level access)
    nwg-displays       = nwg-displays;
    way-displays       = way-displays;
    hyprlock           = hyprlock; # Screen locker for Hyprland
    
    # File Management (system-level)
    ark                = file-roller; # Archive manager (GNOME-based instead of KDE)
    
    # AMD Tools (requiring system access)
    mesa-demos         = mesa-demos;
    radeon-profile     = radeon-profile;
    
    # System Audio (if needed system-wide)
    pavucontrol        = pavucontrol;
    pulseaudio         = pulseaudio;
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
