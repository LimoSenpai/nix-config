{ inputs, pkgs, lib, config, ... }: {

  options = {
    nextcloud.enable = lib.mkEnableOption "Nextcloud Client";
  };

  config = lib.mkIf config.nextcloud.enable {
    home.packages =  with pkgs; [
      nextcloud-client
    ];
  };
}