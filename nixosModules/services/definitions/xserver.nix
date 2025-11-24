{ lib, pkgs }:
{
  xserver = {
    services.xserver = {
      enable = lib.mkDefault true;
      xkb = {
        layout = lib.mkDefault "de";
        variant = lib.mkDefault "nodeadkeys";
      };
    };
  };
}
