{config, pkgs, ... }:

{
  imports =
    [
      ./fonts.nix
      ./nvidia.nix
      ./standard_apps.nix
      ./environment.nix
      ./services.nix
      ./hardware.nix
      ./programs.nix
    ];
}
