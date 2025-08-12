{ config, pkgs, lib, inputs, ... }: {
 
  options = {
    steam.enable = lib.mkEnableOption "Steam";
  };

  config = lib.mkIf config.steam.enable {
    programs = {
      steam = {
        enable = true;
      };
    };
    environment.systemPackages = with pkgs; [
      adwsteamgtk
    ];
  };
}