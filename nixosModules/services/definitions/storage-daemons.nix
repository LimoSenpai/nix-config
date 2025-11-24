{ lib, pkgs }:
{
  storage-daemons = {
    services.udisks2.enable = true;
    services.gvfs.enable = true;
  };
}
