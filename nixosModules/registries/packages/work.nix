{ pkgs }:
with pkgs;
{
  # Network/Authentication (system-level)
  krb5         = krb5;
  keyutils     = keyutils;
  cifs-utils   = cifs-utils;
  
  # Root Authentication Tools
  polkit-gnome = polkit_gnome;
}
