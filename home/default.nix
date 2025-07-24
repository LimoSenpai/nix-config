{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./rice/rice.nix
      ./rice/x_cursor.nix
      ./rice/waybar.nix
      ./rice/hyprland-colors.nix
      #./rice/gtk3.nix

      ./zen.nix
      ./essentials.nix
      ./gaming.nix
      ./cli.nix
      ./options.nix
      
    ];
}
