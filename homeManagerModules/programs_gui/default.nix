{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./easyeffects.nix
      ./loupe.nix
      ./spicetify.nix
      ./vesktop.nix
      ./yubikey.nix
      ./zen.nix
    ];
}
