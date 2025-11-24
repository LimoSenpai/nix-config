{ pkgs, lib, config, ... }:
{
  options.playerctl.enable = lib.mkEnableOption "Playerctl";

  config = lib.mkIf config.playerctl.enable {
    home.packages = [ pkgs.playerctl ];
  };
}
