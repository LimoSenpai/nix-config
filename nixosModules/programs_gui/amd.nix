{ inputs, pkgs, lib, config, ... }: {

  options = {
    amd-radeon.enable = lib.mkEnableOption "AMD Radeon - Display Management";
  };

  config = lib.mkIf config.amd-radeon.enable {
    nixos-apps-gui.enable = [
      "mesa-demos"
      "radeon-profile"
    ];
  };
}

