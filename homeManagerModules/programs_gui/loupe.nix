{ inputs, pkgs, lib, config, ... }: {

  options = {
    loupe.enable = lib.mkEnableOption "loupe - Discord Client";
  };

  config = lib.mkIf config.loupe.enable {
    home.packages =  with pkgs; [
      loupe
    ];
  };
}

