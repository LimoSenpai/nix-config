{ inputs, pkgs, lib, config, ... }: {

  options = {
    gui_utils.enable = lib.mkEnableOption "Ventoy Full GTK";
  };

  config = lib.mkIf config.gui_utils.enable {
    home.packages =  with pkgs; [
      ventoy-full-gtk
    ];
  };
}