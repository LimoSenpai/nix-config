{config, pkgs, ... }:

{
  imports =
    [
      ./programs_cli.nix
      ./cirno_deps.nix
      ./tiny-dfr.nix
    ];
}
