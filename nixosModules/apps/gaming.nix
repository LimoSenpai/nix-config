{ lib, pkgs, config, ... }:
let
  registry = import ../registries/packages/gaming.nix { inherit pkgs; };
  validNames = builtins.attrNames registry;
  cfg = config.nixos-apps-gaming;
in
{
  options.nixos-apps-gaming = {
    enable = lib.mkOption {
      type = lib.types.listOf (lib.types.enum validNames);
      default = [];
      example = [ "lutris" "heroic" ];
      description = "List of registry gaming apps to install system-wide.";
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Arbitrary extra packages not in the registry.";
    };
  };

  options = {
    steam.enable = lib.mkEnableOption "Steam gaming platform";
    gamemode.enable = lib.mkEnableOption "GameMode performance optimization";
  };

  config = lib.mkMerge [
    {
      environment.systemPackages = 
        (builtins.filter (pkg: pkg != null) (map (name: registry.${name}) cfg.enable)) 
        ++ cfg.extraPackages;
    }
    
    (lib.mkIf config.steam.enable {
      programs.steam.enable = true;
    })
    
    (lib.mkIf config.gamemode.enable {
      programs.gamemode.enable = true;
    })
  ];
}
