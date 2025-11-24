{ lib, pkgs }:
{
  power-profiles-daemon = {
    services.power-profiles-daemon.enable = true;
  };
}
