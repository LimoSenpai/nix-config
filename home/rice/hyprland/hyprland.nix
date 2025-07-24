
{ config, pkgs, ... }:

{
  home.file.".config/hypr/hyprland.conf".text = ''
    source = monitors.conf
    source = workspaces.conf


    exec = hyprctl dispatch submap global # DO NOT REMOVE THIS OR YOU WON'T BE ABLE TO USE ANY KEYBIND
    submap = global # This is required for catchall to work



    # Defaults
    source=~/.config/hypr/hyprland/env.conf
    source=~/.config/hypr/hyprland/execs.conf
    source=~/.config/hypr/hyprland/general.conf
    source=~/.config/hypr/hyprland/rules.conf
    #source=~/.config/hypr/hyprland/colors.conf
    source=~/.config/hypr/hyprland/keybinds.conf
  '';
}