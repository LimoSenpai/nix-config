{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./cli_utilities.nix
      ./foot.nix
      ./power-profiles-daemon.nix
      ./playerctl.nix
      ./tiny-dfr.nix
    ];
}
