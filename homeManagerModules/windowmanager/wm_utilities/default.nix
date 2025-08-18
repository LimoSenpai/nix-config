{ config, pkgs, inputs, ... }: {
  imports =
    [  
      ./dunst.nix
      ./x_cursor.nix
      ./cursor.nix
      ./rofi.nix
      ./wofi.nix
      ./waybar.nix
      ./hyprlock.nix
      ./dunst.nix
      ./switchwall.nix
      ./wlogout.nix
      ./waypaper.nix
      ./swww.nix
    ];
}
