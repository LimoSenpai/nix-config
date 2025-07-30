{ inputs, pkgs, lib, config, ... }: {

  options = {
    vesktop.enable = lib.mkEnableOption "Vesktop - Discord Client";
  };

  config = lib.mkIf config.vesktop.enable {
    home.packages =  with pkgs; [
      vesktop
    ];
  };
}

