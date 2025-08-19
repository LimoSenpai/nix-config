{ inputs, pkgs, lib, config, ... }: {

  options = {
    work_default.enable = lib.mkEnableOption "Standard Apps for Work";
  };

  config = lib.mkIf config.work_default.enable {
    nixos-apps-work.enable = [
      "thunderbird-bin"
      "keepassxc"
      "libreoffice-qt-still"
      "krb5"
      "cifs-utils"
      "keyutils"
    ];
  };
}

