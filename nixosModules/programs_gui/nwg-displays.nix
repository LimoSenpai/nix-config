{ inputs, pkgs, lib, config, ... }: {

  options = {
    nwg-displays.enable = lib.mkEnableOption "Nwg Displays - Display Management";
  };

  config = lib.mkIf config.nwg-displays.enable {
    nixos-apps-gui.enable = [
      "nwg-displays"
    ];
  };
}

