{config, pkgs, ... }:

{
  imports =
    [
      ./fonts.nix
      ./nvidia.nix
      ./system_essentials.nix
      ./environment.nix
      ./hardware.nix
      ./programs.nix
    ];
}
