{ lib, pkgs, config, ... }:
let
  # Central registry: name -> package
  registry = with pkgs; {
    # Gaming Platforms
    lutris             = lutris;
    heroic             = heroic;
    
    # Gaming Tools
    gamemode           = gamemode;
    gamescope          = gamescope;
    mangohud           = mangohud;
    
    # Emulators
    retroarch          = retroarch;
    
    # Minecraft
    prismlauncher      = prismlauncher;
    
    # Custom packages
    cirno-downloader   = cirno-downloader;
    
    # Discord Rich Presence
    arrpc              = arrpc;
    
    # Game Tools
    protontricks       = protontricks;
    protonplus         = protonplus;
    adwsteamgtk        = adwsteamgtk;
    moonlight-qt       = moonlight-qt;
    sunshine           = sunshine;

    # Wine
    wine               = wine;
    winetricks         = winetricks;
  };

  validNames = builtins.attrNames registry;
  cfg = config.home-apps-gaming;
in
{
  options.home-apps-gaming = {
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

  config = {
    home.packages =
      (map (name: registry.${name}) cfg.enable)
      ++ cfg.extraPackages;
  };
}
