{ inputs, pkgs, lib, config, ... }: {

  options = {
    power-profiles-daemon.enable = lib.mkEnableOption "Power Profiles Daemon";
  };

  config = lib.mkIf config.power-profiles-daemon.enable {
    home.packages =  with pkgs; [
    power-profiles-daemon
    ];
  };
}