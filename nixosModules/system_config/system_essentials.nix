{ config, lib, pkgs, ... }: {

  options = {
    system-essentials.enable = lib.mkEnableOption "System Essential Packages";
  };

  config = lib.mkIf config.system-essentials.enable {
    environment.systemPackages = with pkgs; [
      # Core system libraries
      bluez
      glib
      
      # Themes and icons (essential for desktop environments)
      hicolor-icon-theme
      adwaita-icon-theme
      gsettings-desktop-schemas
      
      # Essential documentation
      man-db
    ];
  };  
}
