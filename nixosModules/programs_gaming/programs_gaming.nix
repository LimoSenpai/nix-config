{ lib, pkgs, config, ... }:
let
  # Central registry: name -> package/configuration
  registry = with pkgs; {
    # Gaming Platforms
    steam              = null; # Special handling
    lutris             = lutris;
    heroic             = heroic;
    
    # Gaming Tools
    gamemode           = gamemode;
    gamescope          = gamescope;
    mangohud           = mangohud;
    
    # Steam Tools
    adwsteamgtk        = adwsteamgtk;
    protontricks       = protontricks;
    
    # Emulators
    retroarch          = retroarch;
    
    # Minecraft
    prismlauncher      = prismlauncher;
    
    # Custom packages
    cirno-downloader   = cirno-downloader;
  };

  validNames = builtins.attrNames registry;
  cfg = config.nixos-apps-gaming;
in
{
  options.nixos-apps-gaming = {
    enable = lib.mkOption {
      type = lib.types.listOf (lib.types.enum validNames);
      default = [];
      example = [ "steam" "lutris" "gamemode" ];
      description = "List of registry gaming apps to install system-wide.";
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
        (builtins.filter (pkg: pkg != null) (map (name: registry.${name}) cfg.enable)) 
        ++ cfg.extraPackages;
    }
    
    # Special configuration for steam
    (lib.mkIf (builtins.elem "steam" cfg.enable) {
      programs.steam.enable = true;
    })
    
    # Special configuration for gamemode
    (lib.mkIf (builtins.elem "gamemode" cfg.enable) {
      programs.gamemode.enable = true;
    })
  ];
}
