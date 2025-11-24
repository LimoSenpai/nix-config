{ lib, pkgs }:
{
  bluetooth-manager = {
    services.blueman.enable = true;
    services.dbus.packages = [ pkgs.blueman ];
  };
}
