
{ config, lib, pkgs, ... }:
{
  # Hardware
  hardware.bluetooth.enable = true;
  hardware.graphics.enable32Bit = true;
}