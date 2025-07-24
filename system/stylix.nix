{ config, lib, pkgs, inputs, stylix, ... }:

{
  stylix = {
    enable = true;
    image = inputs.self + "/assets/wallpapers/gwen_stacy.jpg";
    polarity = "dark";
  };
}
