{ config, lib, pkgs, inputs, ... }:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    image = inputs.self + "/assets/wallpapers/gwen_stacy.jpg";
  };
}
