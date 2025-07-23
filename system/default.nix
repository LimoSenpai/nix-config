{config, pkgs, ... }:

{
  imports =
    [
      ./wm/hyprland.nix
      ./sddm.nix
      ./gaming.nix
      ./configuration/fonts.nix
      ./configuration/nvidia.nix
      ./configuration/environment.nix
    ];
}
