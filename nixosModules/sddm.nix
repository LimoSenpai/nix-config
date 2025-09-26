  { inputs, pkgs, lib, config, ...}: {
    # I WASTED SO MUCH TIME HERE

  options = {
    sddm.enable = lib.mkEnableOption "SDDM";
  };

  config = lib.mkIf config.sddm.enable (let
  colors = config.lib.stylix.colors.withHashtag;
  in {
    services.displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "astronaut";
      settings = {
        Theme = {
          Current = "astronaut";
          ThemeDir = "${inputs.sddm-astronaut}/share/sddm/themes";
          FacesDir = "/usr/share/sddm/faces";
        };
        General = {
          Background = lib.cleanSource ../assets/wallpapers/current_wallpaper.jpg;
          InputMethod = "";
        };
      };
    };
  });
}

