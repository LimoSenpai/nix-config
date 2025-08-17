{config, pkgs, ... }:

{
  imports =
    [
      ./nwg-displays.nix
      ./pavucontrol.nix
      ./amd.nix
      ./zen.nix
    ];
}
