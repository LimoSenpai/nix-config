{ lib, pkgs }:
{
  sudo-poweroff = {
    security.sudo.enable = lib.mkDefault true;
    security.sudo.extraRules = lib.mkAfter [
      {
        users = [ "tinus" ];
        commands = [{
          command = "/run/current-system/sw/bin/systemctl poweroff";
          options = [ "NOPASSWD" ];
        }];
      }
    ];
  };
}
