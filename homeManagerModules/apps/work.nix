{ lib, pkgs, config, ... }:
let
  registry = import ../registries/packages/work.nix { inherit pkgs; };
  validNames = builtins.attrNames registry;
  cfg = config.home-apps-work;
in
{
  options.home-apps-work = {
    enable = lib.mkOption {
      type = lib.types.listOf (lib.types.enum validNames);
      default = [];
      example = [ "thunderbird" "keepass" "libreoffice" ];
      description = "List of registry work apps to install.";
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
