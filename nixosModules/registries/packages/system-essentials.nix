{ pkgs }:
with pkgs;
{
  # Core system libraries
  bluez                    = bluez;
  glib                     = glib;
  
  # Themes and icons
  hicolor-icon-theme       = hicolor-icon-theme;
  adwaita-icon-theme       = adwaita-icon-theme;
  gsettings-desktop-schemas = gsettings-desktop-schemas;
  
  # Essential documentation
  man-db                   = man-db;
  man-pages                = man-pages;
  man-pages-posix          = man-pages-posix;
  
  # Core utilities
  coreutils                = coreutils;
  util-linux               = util-linux;
  findutils                = findutils;
  
  # Audio libraries
  alsa-lib                 = alsa-lib;
  alsa-utils               = alsa-utils;
  pipewire                 = pipewire;
  
  # Graphics libraries
  mesa                     = mesa;
  vulkan-loader            = vulkan-loader;
  
  # System libraries
  systemd                  = systemd;
  dbus                     = dbus;
  
  # Networking essentials
  networkmanager           = networkmanager;
  wpa_supplicant           = wpa_supplicant;
  ethtool                  = ethtool;
}
