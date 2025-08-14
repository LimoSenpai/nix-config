{ inputs, pkgs, lib, config, ... }: {

  options = {
    hyprlock.enable = lib.mkEnableOption "Nwg Displays - Display Management";
  };

  config = lib.mkIf config.hyprlock.enable {
    environment.systemPackages = with pkgs; [
      hyprlock
    ];
  };
}