{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./programs_cli
      ./programs_gaming
      ./programs_gui
      ./programs_work
      
      ./windowmanager/hyprland 
      ./windowmanager/niri
      ./windowmanager/gnome
      ./windowmanager/wm_utilities
    ];
}
