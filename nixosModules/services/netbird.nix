{ config, pkgs, lib, ... }:{

  options = {
      netbird.enable = lib.mkEnableOption "NetBird VPN client";
    };

  config = lib.mkIf config.netbird.enable {
  
    services.netbird = {
      enable = true;        # provide the daemon & CLI env
      # optional: manage a named client instance (handy if you’ll join multiple networks)
      clients.home = {
        interface   = "nt0";     # default is wt0
        port        = 51820;     # WireGuard listen port
        openFirewall = true;     # open UDP 51820 on this host
        autoStart   = true;

        # If you use self-hosted, set your URLs here; if using NetBird Cloud, you can omit.
        # These are read when you run `netbird up` to do the first login.
        environment = {
          # NB_MANAGEMENT_URL = "https://api.your-netbird.example";
          # NB_ADMIN_URL      = "https://app.your-netbird.example";
        };

        # optional hardening (runs as its own user, tighter systemd sandbox)
        hardened = true;
      };
    };

    # If you use the systray GUI:
    environment.systemPackages = [ pkgs.netbird-ui ];
  };
}
