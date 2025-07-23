{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./zen.nix

      ./essentials.nix
      ./gaming.nix
      ./cli.nix
      ./options.nix

      ./rice.nix
    ];
}
