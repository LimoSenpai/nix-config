{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./programs_gui.nix
      ./spicetify.nix
      ./noctalia.nix
    ];
}
