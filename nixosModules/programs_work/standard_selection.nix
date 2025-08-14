{ inputs, pkgs, lib, config, ... }: {

  options = {
    work_default.enable = lib.mkEnableOption "Standard Apps for Work";
  };

  config = lib.mkIf config.work_default.enable {
    environment.systemPackages = with pkgs; [
      
      thunderbird-bin
      keepassxc
      libreoffice-qt-still

      # kerberos 5
      krb5
      cifs-utils
      keyutils
    ];
  };
}

