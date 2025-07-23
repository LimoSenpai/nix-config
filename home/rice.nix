{inputs, pkgs, lib, ... }:

{
  home.packages =  with pkgs; [
    rofi-wayland
    swww
    waypaper
    rose-pine-cursor
  ];

  programs = {
    waybar = {
      enable = true;
    };
  };
}

