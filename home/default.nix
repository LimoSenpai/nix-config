{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./rice/rice.nix
      ./rice/x_cursor.nix
      ./rice/waybar.nix
      ./zen.nix
      ./essentials.nix
      ./gaming.nix
      ./cli.nix
      ./options.nix
      
    ];
}
