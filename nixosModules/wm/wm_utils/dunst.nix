{ inputs, pkgs, lib, config, ... }: {

  options = {
    dunst.enable = lib.mkEnableOption "Dunst - Notification Daemon";
  };

  config = lib.mkIf config.dunst.enable {
    environment.systemPackages = with pkgs; [
      dunst
    ];
  };
}

