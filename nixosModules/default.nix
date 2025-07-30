{config, pkgs, ... }:

{
  imports =
    [
      ./wm/hyprland
      ./wm/niri
      ./sddm.nix
      ./stylix.nix


      # new Structure
      ./programs_gaming
      ./programs_gui
      ./programs_cli
      ./system_config
    ];
}
