{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./programs_options.nix

      # New Structure
      ./programs_cli
      ./programs_gaming
      ./programs_gui
      
      ./windowmanager/hyprland 
      ./windowmanager/niri
      ./windowmanager/wm_utilities
    ];
}
