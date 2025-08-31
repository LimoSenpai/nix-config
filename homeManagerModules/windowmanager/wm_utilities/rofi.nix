{ inputs, pkgs, lib, config, ... }: {

  options = {
    rofi-wayland.enable = lib.mkEnableOption "Rofi - Application Launcher";
  };

  config = lib.mkIf config.rofi-wayland.enable {
    #home.packages =  with pkgs; [
    #  rofi-wayland
    #];
    #stylix.targets.rofi.enable = true;
    programs = {
      rofi = {
        enable = true;
      };
    };
  };
}

