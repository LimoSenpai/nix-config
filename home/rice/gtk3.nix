{ config, pkgs, lib, ... }:

{
    gtk = {
    enable = true;
    font = {
      name = lib.mkForce "JetBrainsMono Nerd Font Mono";
      size = 12;
    };
    # Theme is controlled by Stylix
    #theme = {
    #  name = "adw-gtk3";
    #  package = pkgs.adw-gtk3;
    #};
    cursorTheme = {
      name = "BreezeX-RosePine";
      size = 26;
    };
  };
}