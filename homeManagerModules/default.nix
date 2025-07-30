{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./windowmanager/hyprland 
      ./windowmanager/wm_utilities
      
      ./programs_options.nix

      # New Structure
      ./programs_cli
      ./programs_gaming
      ./programs_gui
    ];
}
