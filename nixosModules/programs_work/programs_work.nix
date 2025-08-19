{ lib, pkgs, config, ... }:
let
  # Central registry: name -> package/configuration
  registry = with pkgs; {
    # Communication
    thunderbird-bin    = thunderbird-bin;
    element-desktop    = element-desktop;
    
    # Security
    keepassxc          = keepassxc;
    
    # Office
    libreoffice-qt-still = libreoffice-qt-still;
    
    # Network/Authentication
    krb5               = krb5;
    cifs-utils         = cifs-utils;
    keyutils           = keyutils;
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
