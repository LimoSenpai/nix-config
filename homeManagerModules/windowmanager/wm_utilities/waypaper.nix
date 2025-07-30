{ inputs, pkgs, lib, config, ... }: {

  options = {
    waypaper.enable = lib.mkEnableOption "waypaper - Wayland Wallpaper Setter";
  };

  config = lib.mkIf config.waypaper.enable {
    home.packages =  with pkgs; [
      waypaper
    ];
  };
}

