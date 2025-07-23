{inputs, pkgs, lib, ... }:

{
  home.packages =  with pkgs; [
    lutris
    wine
    protonplus
  ]
}

