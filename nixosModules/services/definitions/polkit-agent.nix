{ lib, pkgs }:
{
  polkit-agent = {
    systemd.user.services.polkit-gnome-authentication-agent = {
      description = "PolicyKit Authentication Agent";
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
      };
    };
  };
}
