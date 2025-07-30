{ config, pkgs, inputs, ... }: {
  imports =
    [  
      ./dunst.nix
      ./x_cursor.nix
      ./rose-pine-cursor.nix
      ./rofi.nix
      ./waybar.nix
      ./dunst.nix
      ./switchwall.nix
      ./wlogout.nix
      ./waypaper.nix
      ./swww.nix   
    ];
}
