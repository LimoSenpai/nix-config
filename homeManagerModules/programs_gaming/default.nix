{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./arrpc.nix
      ./lutris.nix
      ./gamemode.nix
      ./gamescope.nix
      ./proton.nix
      ./wine.nix
      ./misc.nix
    ];
}
