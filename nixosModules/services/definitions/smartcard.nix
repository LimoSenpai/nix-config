{ lib, pkgs }:
{
  smartcard = {
    services.pcscd.enable = true;
  };
}
