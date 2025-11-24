{ pkgs }:
with pkgs;
{
  # Communication
  thunderbird        = thunderbird;
  element            = element-desktop;
  
  # Security
  keepass            = keepassxc;
  
  # Office
  libreoffice        = libreoffice-fresh;
  onenote            = p3x-onenote;
  
  # Network/Authentication (user-level)
  geteduroam         = geteduroam;

  arduino-ide        = arduino-ide;

  dbeaver-bin        = dbeaver-bin;
  rustdesk           = rustdesk;
}
