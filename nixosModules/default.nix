{config, pkgs, ... }:

{
  imports =
    [
      ./sddm.nix
      ./stylix.nix


      # new Structure
      ./programs_gaming
      ./programs_gui
      ./programs_cli
      ./system_config


      ./wm/hyprland
      ./wm/niri
      ./wm/bspwm
      ./wm/gnome
      ./wm/wm_utils
      ./wm/kde6
      ./wm/sway
    ];
}
