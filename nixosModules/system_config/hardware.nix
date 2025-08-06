
{ config, lib, pkgs, ... }: {


  # Hardware
  hardware = {
    bluetooth.enable = true;
    graphics.enable32Bit = true;
    graphics.enable = true;
    xpadneo.enable = true;

  };
}