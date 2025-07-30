{config, pkgs, ... }:

{
  imports =
    [
      ./wm/hyprland
      ./sddm.nix
      ./gaming.nix
      ./stylix.nix

      ./configuration/fonts.nix
      ./configuration/nvidia.nix
      ./configuration/environment.nix
      ./configuration/rivalcfg.nix

    ];
}
