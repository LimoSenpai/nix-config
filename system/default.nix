{config, pkgs, ... }:

{
  imports =
    [
      ./wm/hyprland.nix
      ./sddm.nix
    ];
}
