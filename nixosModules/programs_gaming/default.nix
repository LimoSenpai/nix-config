{config, pkgs, ... }:

{
  imports =
    [
      ./programs_gaming.nix
      ./cirno.nix
      ./steam.nix
    ];
}
