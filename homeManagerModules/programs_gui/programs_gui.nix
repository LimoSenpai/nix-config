{ lib, pkgs, config, ... }:
let
  # Central registry: name -> package
  registry = with pkgs; {
    vesktop     = vesktop;
    obsidian    = obsidian;
    bitwarden   = bitwarden-desktop;
    easyeffects = easyeffects;
    brave       = brave;
    loupe       = loupe;
    nextcloud   = nextcloud-client;
    vscode      = vscode-fhs;
    yubikey     = yubikey-personalization-gui;
    goofcord    = goofcord;
    pcmanfm     = pcmanfm;
    discord     = discord;
    teams       = teams-for-linux;
    swaylock-fancy = swaylock-fancy;
    swaynotificationcenter = swaynotificationcenter;
    office      = libreoffice-qt-still;
    joplin      = joplin-desktop;
    kate        = kdePackages.kate;

  };

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
