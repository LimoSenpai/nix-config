{ inputs, pkgs, lib, config, ...}: {

  options = {
    gnome.enable = lib.mkEnableOption "GNOME";
  };

  config = lib.mkIf config.gnome.enable {
    services.xserver = {
      desktopManager.gnome.enable = true;
    };
    environment.systemPackages = with pkgs; [
       gnomeExtensions.pop-shell
       gnome-tweaks
    ];
    environment.gnome.excludePackages = (with pkgs; [
      atomix # puzzle game
      cheese # webcam tool
      epiphany # web browser
      evince # document viewer
      geary # email reader
      gedit # text editor
      gnome-characters
      gnome-music
      gnome-photos
      gnome-terminal
      gnome-tour
      hitori # sudoku game
      iagno # go game
      tali # poker game
      totem # video player
    ]);
  };
}
