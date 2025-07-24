{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./rice.nix
      ./zen.nix
      ./essentials.nix
      ./gaming.nix
      ./cli.nix
      ./options.nix
      ./x_cursor.nix
    ];
}
