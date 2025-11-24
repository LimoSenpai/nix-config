{ lib, pkgs, config, inputs, ... }:
let
  registry = import ../registries/packages/gui.nix { inherit pkgs inputs; };
  validNames = builtins.attrNames registry;
  cfg = config.home-apps-gui;
in
{
  options.home-apps-gui = {
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

  options = {
    obs-studio.enable = lib.mkEnableOption "OBS Studio screen recording and streaming";
  };

  config = {
    home.packages =
      (map (name: registry.${name}) cfg.enable)
      ++ cfg.extraPackages;

    programs.obs-studio = lib.mkIf config.obs-studio.enable {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
      ];
    };
  };
}
