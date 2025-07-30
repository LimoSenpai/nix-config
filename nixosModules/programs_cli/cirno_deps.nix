{ inputs, pkgs, lib, config, ... }: {

  options = {
    cirno_deps.enable = lib.mkEnableOption "Cirno Dependencies";
  };

  config = lib.mkIf config.cirno_deps.enable {
    environment.systemPackages = with pkgs; [
      #cirno
      libxml2
      webkitgtk_4_1
      p7zip

    ];
  };
}

