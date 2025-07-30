{ config, pkgs, lib, inputs, ... }:

let
  switchwall = pkgs.writeShellScriptBin "switchwall" (builtins.readFile ../../../assets/scripts/switchwall.sh);
in {

  options = {
    switchwall.enable = lib.mkEnableOption "switchwall - Wallpaper Switcher";
  };

  config = lib.mkIf config.switchwall.enable {
    home.packages = [ switchwall ];
  };
}
