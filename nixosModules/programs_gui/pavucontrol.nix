{ inputs, pkgs, lib, config, ... }: {

  options = {
    pavucontrol.enable = lib.mkEnableOption "PulseAudio Volume Control";
  };

  config = lib.mkIf config.pavucontrol.enable {
    nixos-apps-gui.enable = [
      "pavucontrol"
    ];
  };
}

