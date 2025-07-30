{ inputs, pkgs, lib, config, ... }: {

  options = {
    proton.enable = lib.mkEnableOption "Proton - Addons";
  };

  config = lib.mkIf config.proton.enable {
    home.packages =  with pkgs; [
      protontricks
      protonplus
    ];
  };
}

