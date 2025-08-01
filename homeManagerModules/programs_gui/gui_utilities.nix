{ inputs, pkgs, lib, config, ... }: {

  options = {
    ventoy-full-gtk.enable = lib.mkEnableOption "Ventoy Full GTK";
  };

  config = lib.mkIf config.ventoy-full-gtk.enable {
    home.packages =  with pkgs; [
      ventoy-full-gtk
    ];
  };
}