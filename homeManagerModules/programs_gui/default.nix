{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./spicetify.nix
      ./programs_gui.nix
      ./sine.nix
    ];
}
