{config, pkgs, ... }:

{
  imports =
    [
      ./dunst.nix
      ./libnotify.nix
      ./wleave.nix
    ];
}
