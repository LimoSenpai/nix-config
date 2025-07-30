{ inputs, pkgs, lib, config, ... }: {

  options = {
    swww.enable = lib.mkEnableOption "swww - Simple Wayland Wallpaper Switcher";
  };

  config = lib.mkIf config.swww.enable {
    home.packages =  with pkgs; [
      swww
    ];
  };
}

