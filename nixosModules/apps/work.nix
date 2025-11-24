{ lib, pkgs, config, ... }:
let
  registry = import ../registries/packages/work.nix { inherit pkgs; };
  validNames = builtins.attrNames registry;
  cfg = config.nixos-apps-work;
in
{
  options.nixos-apps-work = {
    enable = lib.mkOption {
      type = lib.types.listOf (lib.types.enum validNames);
      default = [];
      example = [ "thunderbird-bin" "keepassxc" "libreoffice-qt-still" ];
      description = "List of registry work apps to install system-wide.";
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Arbitrary extra packages not in the registry.";
    };
  };

  config = lib.mkIf (cfg.enable != []) {
    environment.systemPackages = 
      (map (name: registry.${name}) cfg.enable) ++ cfg.extraPackages ++
      [ pkgs.keyutils ];
  };
}
