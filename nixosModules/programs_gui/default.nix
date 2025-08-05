{config, pkgs, ... }:

{
  imports =
    [
      ./nwg-displays.nix
      ./pavucontrol.nix
      ./gui_utilities.nix
    ];
}
