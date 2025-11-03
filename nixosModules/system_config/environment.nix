{ lib, ... }:
{
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