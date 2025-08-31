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
    btop               = btop;
    tree               = tree;
    unzip              = unzip;
    zip                = zip;
    xz                 = xz;
    rsync              = rsync;
    openssh            = openssh;
    killall            = killall;
    eza                = eza; # A modern replacement for 'ls'
    fzf                = fzf; # A command-line fuzzy finder
    
    # Development Tools
    gcc                = gcc;
    gnumake            = gnumake;
    
    # Network Tools
    nmap               = nmap;
    tcpdump            = tcpdump;
    wireshark-cli      = wireshark-cli;
    netbird            = netbird;

    # System Tools
    lsof               = lsof;
    strace             = strace;
    file               = file;
    which              = which;
    evtest             = evtest;
    
    # System Monitoring
    iotop              = iotop;
    iftop              = iftop;
    sysstat            = sysstat;
    lm_sensors         = lm_sensors;
    ethtool            = ethtool;
    pciutils           = pciutils;
    usbutils           = usbutils;
    
    # Archive Tools
    p7zip              = p7zip;
    gnutar             = gnutar;
    zstd               = zstd;
    
    # Text Processing
    gnused             = gnused;
    gawk               = gawk;
    
    # XML/Web Tools
    libxml2            = libxml2;
    
    # Security
    gnupg              = gnupg;
    
    # Hardware specific
    tiny-dfr           = tiny-dfr;
    nvtop              = nvtopPackages.v3d;
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
