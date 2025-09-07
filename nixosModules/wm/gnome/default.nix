{ inputs, pkgs, lib, config, ...}: {

  options = {
    gnome.enable = lib.mkEnableOption "GNOME";
  };

  config = lib.mkIf config.gnome.enable {
    services.desktopManager = {

      #displayManager.gdm.enable = true;
      gnome.enable = true;
    };
    
    environment.systemPackages = with pkgs; [
       gnomeExtensions.pop-shell
       gnomeExtensions.blur-my-shell
       gnomeExtensions.dash-to-panel
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
