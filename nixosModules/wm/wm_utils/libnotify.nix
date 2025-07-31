{ inputs, pkgs, lib, config, ... }: {

  options = {
    libnotify.enable = lib.mkEnableOption "Libnotify - Notification Daemon";
  };

  config = lib.mkIf config.libnotify.enable {
    environment.systemPackages = with pkgs; [
      libnotify
    ];
  };
}

