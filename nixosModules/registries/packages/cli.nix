{ pkgs }:
with pkgs;
{
  # Network Tools (requiring root privileges)
  nmap               = nmap;
  tcpdump            = tcpdump;
  wireshark-cli      = wireshark-cli;
  netbird            = netbird;
  
  # System Monitoring (requiring root/system access)
  lm_sensors         = lm_sensors;
  ethtool            = ethtool;
  pciutils           = pciutils;
  usbutils           = usbutils;
  nvtop              = nvtopPackages.v3d;
  
  # Hardware Specific
  tiny-dfr           = tiny-dfr;
}
