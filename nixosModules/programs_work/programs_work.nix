{ lib, pkgs, config, ... }:
let
  # Central registry: name -> package/configuration
  registry = with pkgs; {
    # Communication
    thunderbird        = thunderbird-bin;
    element            = element-desktop;
    
    # Security
    keepass            = keepassxc;
    
    # Office
    libreoffice        = libreoffice-qt-still;
    
    # Network/Authentication
    krb5               = krb5;
    keyutils           = keyutils;
    cifs-utils         = cifs-utils;
    geteduroam         = geteduroam;
    
    # Root Authentication Tools
    lxqt-sudo          = lxqt.lxqt-sudo;
    polkit-gnome       = polkit_gnome;
  };

  validNames = builtins.attrNames registry;
  cfg = config.nixos-apps-work;
in
{
  options.nixos-apps-work = {
    enable = lib.mkOption {
      type = lib.types.listOf (lib.types.enum validNames);
      default = [];
      example = [ "thunderbird-bin" "keepassxc" "libreoffice-qt-still" ];
      description = "List of registry work apps to install system-wide.";
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Arbitrary extra packages not in the registry.";
    };
  };

  config = {
    environment.systemPackages = 
      (map (name: registry.${name}) cfg.enable) ++ cfg.extraPackages;
  };
}
