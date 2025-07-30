{config, pkgs, ... }:

{
  imports =
    [
      ./wm/hyprland
      ./sddm.nix
      ./stylix.nix


      # new Structure
      ./programs_gaming
      ./programs_gui
      ./programs_cli
      ./system_config
    ];
}
