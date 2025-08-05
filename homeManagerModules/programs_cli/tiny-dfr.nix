{ inputs, pkgs, lib, config, ... }: {

  options = {
    mbp-touchbar.enable = lib.mkEnableOption "Touch Bar support for MacBook Pro";
  };

  config = lib.mkIf config.mbp-touchbar.enable {
    home.packages =  with pkgs; [
    tiny-dfr
    ];
  };
}