{ lib, pkgs, config, inputs, ... }:
let
  registry = import ../registries/packages/gui.nix { inherit pkgs; };
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
