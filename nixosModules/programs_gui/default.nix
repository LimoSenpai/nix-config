{config, pkgs, ... }:

{
  imports =
    [
      ./programs_gui.nix
      ./spicetify.nix
    ];
}
