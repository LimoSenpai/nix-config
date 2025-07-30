{ inputs, pkgs, lib, config, ... }: {

  options = {
    bitwarden.enable = lib.mkEnableOption "Bitwarden - Password Manager";
  };

  config = lib.mkIf config.bitwarden.enable {
    home.packages =  with pkgs; [
      bitwarden-desktop
    ];
  };
}