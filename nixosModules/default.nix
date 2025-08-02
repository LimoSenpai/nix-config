{config, pkgs, ... }:

{
  imports =
    [
      ./wm/hyprland
      ./wm/niri
      ./wm/bspwm
      ./wm/wm_utils
      ./sddm.nix
      ./stylix.nix


      # new Structure
      ./programs_gaming
      ./programs_gui
      ./programs_cli
      ./system_config
    ];
}
