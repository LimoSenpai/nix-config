{config, pkgs, ... }:

{
  imports =
    [
      ./wm/hyprland.nix
      ./sddm.nix
      ./gaming.nix
      ./fonts.nix
    ];
}
