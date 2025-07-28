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
      ./programs_gaming.nix
      ./programs_cli.nix
      ./programs_gui.nix
      ./programs_options.nix
      
    ];
}
