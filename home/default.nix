{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./rice/rice.nix
      ./rice/x_cursor.nix
      ./rice/waybar.nix

      ./rice/switchwall.nix

      ./rice/hyprland/hyprland.nix
      ./rice/hyprland/wlogout.nix
      

      ./zen.nix
      ./essentials.nix
      ./gaming.nix
      ./cli.nix
      ./options.nix
      
    ];
}
