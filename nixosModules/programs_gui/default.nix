{config, pkgs, ... }:

{
  imports =
    [
      ./nwg-displays.nix
      ./pavucontrol.nix
    ];
}
