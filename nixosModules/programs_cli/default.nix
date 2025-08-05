{config, pkgs, ... }:

{
  imports =
    [
      ./cli_utilities.nix
      ./cirno_deps.nix
      ./tiny-dfr.nix
    ];
}
