
{ lib, pkgs, config, ... }:
let
  registry = import ./definitions { inherit lib pkgs; };

  validNames = builtins.attrNames registry;
  defaultServices = validNames;

  cfg = config.nixos-services;
in
{
  options.nixos-services = {
    enable = lib.mkOption {
      type = lib.types.listOf (lib.types.enum validNames);
      default = defaultServices;
      example = [ "polkit-agent" "openssh" "sudo-poweroff" ];
      description = "Service bundles to enable.";
    };
  };

  config = lib.mkMerge (
    map (name: lib.mkIf (lib.elem name cfg.enable) registry.${name}) validNames
  );
}
