{ lib, pkgs, config, ... }:
let
  registry = import ../registries/packages/system-essentials.nix { inherit pkgs; };
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
    #{
    #  systemd.services."wol-${iface}" = {
    #    description = "Enable Wake-on-LAN on ${iface}";
    #    wantedBy = [ "multi-user.target" ];
    #    after = [ "network-online.target" ];
    #    serviceConfig = {
    #      Type = "oneshot";
    #      ExecStart = "${pkgs.ethtool}/sbin/ethtool -s ${iface} wol g";
    #    };
    #  };
    #}
  ];
}
