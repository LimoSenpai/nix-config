
{ config, lib, pkgs, ... }:
{

  # Using polkit-gnome instead of lxqt-policykit due to Qt6 build issues
  systemd.user.services.polkit-gnome-authentication-agent = {
    description = "PolicyKit Authentication Agent";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
    };
  };


  # Environment Settings
  environment.variables = {
    XCURSOR_THEME = "GoogleDot-Black";
    XCURSOR_SIZE = 25;
    NIXOS_OZONE = "1"; # Enable Ozone for Hyprland
  };
  
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        .zen-wrapped
      ''; 
      mode = "0755";
    };
    "modprobe.d/apple-gmux.conf" = {
      text = ''
        options apple-gmux force_idg=y
      '';
    };
  };

  environment.etc."idmapd.conf".text = lib.mkForce ''
    [General]
    Domain = lan
    Pipefs-Directory=/var/lib/nfs/rpc_pipefs

    [Mapping]
    Nobody-Group=nogroup
    Nobody-User=nobody

    [Translation]
    Method=nsswitch
  '';
}