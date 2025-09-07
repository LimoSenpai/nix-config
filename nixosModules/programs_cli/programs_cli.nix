{ lib, pkgs, config, ... }:
let
  # Central registry: name -> package/configuration
  registry = with pkgs; {
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
  };

  validNames = builtins.attrNames registry;
  cfg = config.nixos-apps-cli;
in
{
  options.nixos-apps-cli = {
    enable = lib.mkOption {
      type = lib.types.listOf (lib.types.enum validNames);
      default = [];
      example = [ "git" "curl" "tiny-dfr" ];
      description = "List of registry CLI apps to install system-wide.";
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Arbitrary extra packages not in the registry.";
    };
  };

  config = lib.mkMerge [
    {
      environment.systemPackages = 
        (map (name: registry.${name}) cfg.enable) ++ cfg.extraPackages;
    }
    
    # Special hardware configuration for tiny-dfr
    (lib.mkIf (builtins.elem "tiny-dfr" cfg.enable) {
      hardware.apple.touchBar = {
        enable = true;
        settings = {
          MediaLayerDefault = true;
          EnablePixelShift = true;
          AdaptiveBrightness = true;
        };
      };
    })
  ];
}
