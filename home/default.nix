{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./zen.nix
      
      ./essentials.nix
      ./cli.nix
      ./options.nix
    ];
}
