{config, pkgs, ... }:

{
  imports =
    [
      ./wm/hyprland.nix
      ./sddm.nix
      ./gaming.nix
      ./stylix.nix

      ./configuration/fonts.nix
      ./configuration/nvidia.nix
      ./configuration/environment.nix
      ./configuration/global_apps.nix

      ./rice/dunst.nix
    ];
}
