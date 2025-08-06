{config, pkgs, ... }:

{
  imports =
    [
      ./cirno_deps.nix
      ./tiny-dfr.nix
    ];
}
