{ inputs, pkgs, lib, config, ... }: {

  options = {
    yubikey.enable = lib.mkEnableOption "Yubikey - Security Key Support";
  };

  config = lib.mkIf config.yubikey.enable {
    home.packages =  with pkgs; [
      yubikey-personalization-gui
    ];
  };
}

