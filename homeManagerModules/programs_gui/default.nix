{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./spicetify.nix
      ./zen.nix
      ./programs_gui.nix
    ];
}
