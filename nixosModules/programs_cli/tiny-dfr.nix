{ inputs, pkgs, lib, config, ... }: {

  options = {
    mbp_touchbar.enable = lib.mkEnableOption "MacBook Pro Touch Bar";
  };

  config = lib.mkIf config.mbp_touchbar.enable {
    environment.systemPackages = with pkgs; [
      tiny-dfr
    ];

    hardware = {
      apple.touchBar = {
        enable = true;
        settings = {
          MediaLayerDefault = true;
          EnablePixelShift = true;
          AdaptiveBrightness = true;
        };
      };
    };
  };
}

