{ inputs, pkgs, lib, config, ... }: {

  options = {
    wofi.enable = lib.mkEnableOption "Wofi - Application Launcher";
  };

  config = lib.mkIf config.wofi.enable {
    home.packages =  with pkgs; [
      wofi
    ];
    stylix.targets.wofi.enable = true;
  };
}

