{ lib, pkgs, config, ... }:
let
  # Central registry: name -> package
  registry = with pkgs; {
    fastfetch   = fastfetch;
    yazi        = yazi;
    grimblast   = grimblast; # Screenshot tool
    mdadm       = mdadm;
    jq          = jq;
    hyperfine   = hyperfine;
    icu         = icu;
    wireguard   = wireguard;
    rg          = ripgrep;
    tmux        = tmux;
    alacritty   = alacritty;
  };

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
      userName = "Tinus Braun";
      userEmail = "brauntinus@gnetic.pro";
    };
  };
}
