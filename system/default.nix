{config, pkgs, ... }:

{
  imports =
    [
      ./wm/hyprland.nix
      ./lockscreen/sddm.nix
    ];
}
