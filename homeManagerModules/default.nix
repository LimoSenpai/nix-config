{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./rice/hyprland
      
      ./rice/rice.nix
      ./rice/x_cursor.nix
      ./rice/waybar.nix
      ./rice/dunst.nix
      ./rice/switchwall.nix
      ./rice/wlogout.nix
      

      ./zen.nix
      ./programs_gaming.nix
      ./programs_cli.nix
      ./programs_gui.nix
      ./programs_options.nix
      
    ];
}
