{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./sddm.nix
      ./stylix.nix


      # Application sets
      ./apps/cli.nix
      ./apps/gui.nix
      ./apps/gaming.nix
      ./apps/work.nix
      ./apps/spicetify.nix
      ./apps/noctalia.nix
      ./system_config
      ./services


      ./wm/hyprland
      ./wm/niri
      ./wm/bspwm
      #./wm/gnome
      ./wm/wm_utils
      ./wm/kde6
      ./wm/sway
    ];
}
