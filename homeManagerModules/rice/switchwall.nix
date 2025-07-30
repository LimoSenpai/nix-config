{ config, pkgs, ... }:

let
  switchwall = pkgs.writeShellScriptBin "switchwall" (builtins.readFile ../../assets/scripts/switchwall.sh);
in {
  home.packages = [ switchwall ];
}
