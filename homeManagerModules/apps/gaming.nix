{ lib, pkgs, config, ... }:
let
  registry = import ../registries/packages/gaming.nix { inherit pkgs; };
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
