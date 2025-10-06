{ inputs, pkgs, lib, config, options, ... }:
{
  options = {
    sddm.enable = lib.mkEnableOption "SDDM";
  };

  config = lib.mkIf config.sddm.enable {
    services.displayManager.sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;        # Qt6 SDDM
        theme = "astronaut"; # Theme folder name in /usr/share/sddm/themes/
        settings = {
          Theme = {
            ThemeDir = "${pkgs.sddm-astronaut-hyprland_kath}/share/sddm/themes";
          };
        };
        # Ensure SDDM has access to necessary Qt plugins
        extraPackages = with pkgs.kdePackages; [
          qtmultimedia
          qtsvg
          qtvirtualkeyboard
          qtquick3d
        ];
        autoLogin = {
          enable = true;
          user = "tinus";
        };
      };
    };

}
