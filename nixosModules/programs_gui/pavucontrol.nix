{ inputs, pkgs, lib, config, ... }: {

  options = {
    pavucontrol.enable = lib.mkEnableOption "PulseAudio Volume Control";
  };

  config = lib.mkIf config.pavucontrol.enable {
    environment.systemPackages = with pkgs; [
      pavucontrol
    ];
  };
}

