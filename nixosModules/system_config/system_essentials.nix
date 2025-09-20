{ lib, pkgs, config, ... }:
let
  # Central registry: name -> package/configuration
  registry = with pkgs; {
    # Core system libraries
    bluez                    = bluez;
    glib                     = glib;
    
    # Themes and icons (essential for desktop environments)
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
  };

  validNames = builtins.attrNames registry;
  cfg = config.nixos-system-essentials;

  iface = "enp12s0";
in
{
  options.nixos-system-essentials = {
    enable = lib.mkOption {
      type = lib.types.listOf (lib.types.enum validNames);
      default = [];
      example = [ "bluez" "glib" "hicolor-icon-theme" "man-db" ];
      description = "List of essential system packages to install.";
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Arbitrary extra essential packages not in the registry.";
    };
  };

  config = lib.mkMerge [
    {
      environment.systemPackages =
        (map (name: registry.${name}) cfg.enable) ++ cfg.extraPackages;
    }

    (lib.mkIf (builtins.elem "networkmanager" cfg.enable) {
      networking.networkmanager.enable = true;
    })

    (lib.mkIf (builtins.elem "pipewire" cfg.enable) {
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    })

    # WoL service now under `config`
    {
      systemd.services."wol-${iface}" = {
        description = "Enable Wake-on-LAN on ${iface}";
        wantedBy = [ "multi-user.target" ];
        after = [ "network-online.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.ethtool}/sbin/ethtool -s ${iface} wol g";
        };
      };
    }
  ];
}
