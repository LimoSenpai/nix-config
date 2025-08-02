{ config, pkgs, stylix, lib, inputs, ... }: {

  options = {
    gnome.enable = lib.mkEnableOption "GNOME";
  };

  config = lib.mkIf config.gnome.enable {
<<<<<<< HEAD
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
=======
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
>>>>>>> f81ddbdc4e7814e579cf16594fd340abf7bb4ac4

  };
}
