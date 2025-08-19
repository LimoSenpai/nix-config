{ inputs, pkgs, lib, config, ... }: {

  options = {
    mbp_touchbar.enable = lib.mkEnableOption "MacBook Pro Touch Bar";
  };

  config = lib.mkIf config.mbp_touchbar.enable {
    nixos-apps-cli.enable = [
      "tiny-dfr"
    ];
  };
}

