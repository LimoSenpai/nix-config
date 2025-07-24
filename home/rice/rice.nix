{inputs, pkgs, lib, ... }:

{
  home.packages =  with pkgs; [
    rofi-wayland
    rofi-power-menu
    swww
    waypaper
    rose-pine-cursor
  ];
  stylix.targets.waybar.enable = false;
}

