{ config, lib, pkgs, inputs, stylix, ... }:


let
  opacity = 0.95;
in
{
  stylix = {
    enable = true;
    image = inputs.self + "/assets/wallpapers/current_wallpaper.jpg";
    polarity = "dark";
    opacity = {
      terminal = opacity;
      popups = opacity;
    };
    fonts = {
      serif = {
        package = pkgs.aleo-fonts;
        name = "Aleo";
      };

      sansSerif = {
        package = pkgs.noto-fonts-cjk-sans;
        name = "Noto Sans CJK JP";
      };

      monospace = {
        package = pkgs.maple-mono.variable;
        name = "Maple Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
