{ lib, pkgs, config, ... }:
let
  # Central registry: name -> package
  registry = with pkgs; {
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
  };

  validNames = builtins.attrNames registry;
  cfg = config.home-apps-work;
in
{
  options.home-apps-work = {
    enable = lib.mkOption {
      type = lib.types.listOf (lib.types.enum validNames);
      default = [];
      example = [ "thunderbird" "keepass" "libreoffice" ];
      description = "List of registry work apps to install.";
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Arbitrary extra packages not in the registry.";
    };
  };

  config = {
    home.packages =
      (map (name: registry.${name}) cfg.enable)
      ++ cfg.extraPackages;
  };
}
