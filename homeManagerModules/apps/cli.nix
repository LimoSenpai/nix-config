{ lib, pkgs, config, ... }:
let
  registry = import ../registries/packages/cli.nix { inherit pkgs; };
  validNames = builtins.attrNames registry;
  cfg = config.home-apps-cli;
in
{
  options.home-apps-cli = {
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

  options ={
    alacritty.enable  = lib.mkEnableOption "Alacritty Terminal";
    git.enable = lib.mkEnableOption "Git version control";
    pinentry.enable = lib.mkEnableOption "Pinentry for GnuPG";
  };

  config = {
    home.packages =
      (map (name: registry.${name}) cfg.enable)
      ++ cfg.extraPackages;

    programs.alacritty = lib.mkIf config.alacritty.enable {
      enable = true;
    };

    programs.git = lib.mkIf config.git.enable {
      enable = true;
      settings = {
        user.name = "Tinus Braun";
        user.email = "brauntinus@gnetic.pro";
      };
    };

  };
}
