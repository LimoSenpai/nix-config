# modules/work/ad-cifs.nix
{ lib, pkgs, config, ... }:
let
  cfg = config.work.adCifs;
in {
  options.work.adCifs = {
    enable = lib.mkEnableOption "Mount AD CIFS shares via Kerberos (pam_mount)";
    server = lib.mkOption {
      type = lib.types.str;
      default = "vsrz001.hrz-services.uni-marburg.de";
      description = "SMB server (FQDN required for Kerberos).";
    };
    realm = lib.mkOption {
      type = lib.types.str;
      default = "AD.UNI-MARBURG.DE";
    };
    domain = lib.mkOption {
      type = lib.types.str;
      default = "AD";
    };
    smbVersion = lib.mkOption {
      type = lib.types.str;
      default = "3.0"; # 3.0/3.1.1 is generally safer than 2.0
    };
    # Only users in this group will get the mounts (keeps root/sudo out)
    gateGroup = lib.mkOption {
      type = lib.types.str;
      default = "ad-cifs";
    };
    shares = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          name = lib.mkOption { type = lib.types.str; };
          path = lib.mkOption { type = lib.types.str; }; # e.g. "HRZ_H$/%(USER)" or "HRZ_K$"
        };
      });
      default = [
        { name = "HRZ_H"; path = "HRZ_H$/%(USER)"; }
        { name = "HRZ_K"; path = "HRZ_K$"; }
      ];
    };
  };

  config = lib.mkIf cfg.enable {
    # Tools
    environment.systemPackages = with pkgs; [ krb5 cifs-utils keyutils ];

    # Ensure the kernel can invoke cifs.upcall for SPNEGO tickets.
    # (Without this, you'll get the "Verify user has a krb5 ticket..." spam.)
    environment.etc."request-key.d/cifs.spnego.conf".text = ''
      create cifs.spnego * * ${pkgs.cifs-utils}/bin/cifs.upcall %k
    '';
    environment.etc."request-key.d/dns_resolver.conf".text = ''
      create dns_resolver * * ${pkgs.cifs-utils}/bin/cifs.upcall %k
    '';

    # Kerberos client config (keyring ccache is important for CIFS).
    security.krb5 = {
      enable = true;
      settings = {
        libdefaults = {
          default_realm = cfg.realm;
          dns_lookup_kdc = true;
          rdns = false;
          udp_preference_limit = 0;
          ticket_lifetime = "8h";
          renew_lifetime = "7d";
          default_ccache_name = "KEYRING:persistent:%{uid}";
        };
        domain_realm = {
          ".uni-marburg.de" = cfg.realm;
          "uni-marburg.de"  = cfg.realm;
        };
      };
    };

    # Get a TGT at (graphical/tty) login using the user's password.
    security.pam.krb5.enable = true;

    # Gate who gets mounts (avoid root/sudo sessions).
    users.groups.${cfg.gateGroup} = {}; # create the group; add yourself to it in your host config:
    # users.users.tinus.extraGroups = [ cfg.gateGroup ];

    security.pam.mount = {
      enable = true;
      createMountPoints = true;

      # Only attach pam_mount on real logins; keep it OFF for sudo/su so root won't try to mount.
      # If any of these services don't exist in your stack, harmless no-ops.
      };
    security.pam.services.sudo.pamMount = false;
    security.pam.services.su.pamMount = false;
    security.pam.services."su-l".pamMount = false;
    security.pam.services."polkit-1".pamMount = false;

    # Volumes: one per share, gated by the group.
    security.pam.mount.extraVolumes =
      let mkVol = s: ''
        <volume
          fstype="cifs"
          server="${cfg.server}"
          path="${s.path}"
          mountpoint="/run/user/%(USERUID)/netmount/${s.name}"
          sgrp="${cfg.gateGroup}"
          options="sec=krb5i,vers=${cfg.smbVersion},cruid=%(USERUID),uid=%(USERUID),gid=%(USERGID),nodev,nosuid" />
      '';
      in map mkVol cfg.shares;

    # Time sync is critical for Kerberos; this is usually on by default, but let's be explicit.
    services.timesyncd.enable = true;
  };
}
