{config, pkgs, ... }:

{
  imports =
    [
      ./cli_utilities.nix
      ./cirno_deps.nix
    ];
}
