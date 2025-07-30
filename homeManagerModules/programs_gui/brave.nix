{ inputs, pkgs, lib, config, ... }: {

  options = {
    brave.enable = lib.mkEnableOption "brave - Web Browser";
  };

  config = lib.mkIf config.brave.enable {
    home.packages =  with pkgs; [
      brave
    ];
  };
}