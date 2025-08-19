{ inputs, pkgs, lib, config, ... }: {

  options = {
    cirno_deps.enable = lib.mkEnableOption "Cirno Dependencies";
  };

  config = lib.mkIf config.cirno_deps.enable {
    nixos-apps-cli.enable = [
      "libxml2"
      "p7zip"
    ];
    
    nixos-apps-cli.extraPackages = with pkgs; [
      webkitgtk_4_1
      #cirno  # Uncomment when available
    ];
  };
}

