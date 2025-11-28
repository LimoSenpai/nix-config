{config, pkgs, inputs, ... }:

{
  imports =
    [
      ./apps/cli.nix
      ./apps/gui.nix
      ./apps/gaming.nix
      ./apps/work.nix
      ./apps/foot.nix
      ./apps/wezterm.nix
      ./apps/playerctl.nix
      ./apps/power-profiles-daemon.nix
      ./apps/gaming-misc.nix
      ./apps/zen-browser.nix

      ./windowmanager/hyprland 
      ./windowmanager/niri
      ./windowmanager/gnome
      ./windowmanager/wm_utilities
    ];
}
