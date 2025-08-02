{ config, pkgs, stylix, lib, inputs, ... }: {

  options = {
    gnome.enable = lib.mkEnableOption "GNOME";
  };

  config = lib.mkIf config.gnome.enable {
    home-manager.users.myuser = {
        dconf = {
            enable = true;
            settings = {
                "org/gnome/shell" = {
                    disable-user-extensions = false;
                    enabled-extensions = with pkgs.gnomeExtensions; 
                    [
                        blur-my-shell.extensionUuid
                        gsconnect.extensionUuid
                    ];
                };
                "org/gnome/desktop/interface".color-scheme = "prefer-dark";
            };
        };
    };

  };
}
