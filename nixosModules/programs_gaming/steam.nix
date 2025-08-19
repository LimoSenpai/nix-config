{ config, pkgs, lib, inputs, ... }: {
 
  options = {
    steam.enable = lib.mkEnableOption "Steam";
  };

  config = lib.mkIf config.steam.enable {
    nixos-apps-gaming.enable = [
      "steam"
      "adwsteamgtk"
    ];
  };
}