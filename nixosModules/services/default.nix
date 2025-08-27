{config, pkgs, ... }:

{
  imports =
    [
      ./services.nix
      ./netbird.nix
    ];
}
