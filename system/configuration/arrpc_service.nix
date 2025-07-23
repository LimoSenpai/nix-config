{ config, ... }:

{
  systemd.user.services.arrpc = {
  enable = true;
  after = [ "network.target" ];
  wantedBy = [ "default.target" ];
  description = "arrpc service for Vesktop";
  serviceConfig = {
      Type = "simple";
      ExecStart = ''/etc/profiles/per-user/tinus/bin/arrpc'';
  };
};

}