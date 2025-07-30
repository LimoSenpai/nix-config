{ inputs, pkgs, lib, config, ... }: {

  options = {
    easyeffects.enable = lib.mkEnableOption "EasyEffects GUI for PipeWire and PulseAudio";
  };

  config = lib.mkIf config.easyeffects.enable {
    home.packages =  with pkgs; [
      easyeffects
    ];
  };
}