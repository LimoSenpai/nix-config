{ inputs, pkgs, lib, config, ... }: {

  options = {
    nwg-displays.enable = lib.mkEnableOption "Nwg Displays - Display Management";
  };

  config = lib.mkIf config.nwg-displays.enable {
    environment.systemPackages = with pkgs; [
      nwg-displays
    ];
  };
}

