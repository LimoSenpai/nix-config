{config, pkgs, ... }:

{
  imports =
    [
      ./programs_gui.nix
      ./nwg-displays.nix
      ./pavucontrol.nix
      ./amd.nix
      ./zen.nix
    ];
}
