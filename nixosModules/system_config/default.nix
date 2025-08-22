{config, pkgs, ... }:

{
  imports =
    [
      ./fonts.nix
      ./nvidia.nix
      ./system_essentials.nix
      ./environment.nix
      ./services.nix
      ./hardware.nix
      ./programs.nix
      ./work_drive.nix
    ];
}
