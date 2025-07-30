{ inputs, pkgs, lib, config, ... }: {

  options = {
    cli_utilities.enable = lib.mkEnableOption "CLI Utilities";
  };

  config = lib.mkIf config.cli_utilities.enable {
    environment.systemPackages = with pkgs; [
      git
      nano
      wget
      bluez
      glib

    ];
  };
}

