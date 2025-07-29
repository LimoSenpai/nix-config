{ config, pkgs, lib, ... }:

let
  rivalcfg = import ../../pkgs/rivalcfg.nix {
    inherit (pkgs) lib stdenv fetchFromGitHub python3Packages;
  };
in {
  services.udev.packages = [ rivalcfg ];
  environment.systemPackages = [ rivalcfg ];
}
