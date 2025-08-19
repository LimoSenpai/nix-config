{ lib, pkgs, config, ... }:
let
  # Central registry: name -> package/configuration
  registry = with pkgs; {
    # CLI Tools
    git                = git;
    curl               = curl;
    wget               = wget;
    vim                = vim;
    nano               = nano;
    htop               = htop;
    tree               = tree;
    unzip              = unzip;
    zip                = zip;
    rsync              = rsync;
    openssh            = openssh;
    
    # Development Tools
    gcc                = gcc;
    gnumake            = gnumake;
    
    # Network Tools
    nmap               = nmap;
    tcpdump            = tcpdump;
    wireshark-cli      = wireshark-cli;
    
    # System Tools
    lsof               = lsof;
    strace             = strace;
    file               = file;
    which              = which;
    
    # Archive Tools
    p7zip              = p7zip;
    
    # XML/Web Tools
    libxml2            = libxml2;
    
    # Hardware specific
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
