
{ config, lib, pkgs, ... }: 
let
  cfg = config.work_drive;
in
{
  options = {
    work_drive.enable = lib.mkEnableOption "Work Group Drive";
  };

  config = lib.mkIf cfg.enable {

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
          default_realm = "AD.UNI-MARBURG.DE";
          dns_lookup_kdc = true;
          rdns = false;
          udp_preference_limit = 0;
          ticket_lifetime = "8h";
          renew_lifetime = "7d";
          default_ccache_name = "KEYRING:persistent:%{uid}";
        };
        domain_realm = {
          ".uni-marburg.de" = "AD.UNI-MARBURG.DE";
          "uni-marburg.de"  = "AD.UNI-MARBURG.DE";
        };
      };
    };

    # Get a TGT at (graphical/tty) login using the user's password.
    security.pam.krb5.enable = true;

    # Create the ad-cifs group for CIFS mounting
    users.groups.ad-cifs = {};

    # Time sync is critical for Kerberos; this is usually on by default, but let's be explicit.
    services.timesyncd.enable = true;
  };  
}
