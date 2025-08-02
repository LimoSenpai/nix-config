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
      sugarCandyNix = {
        enable = true;
        settings = {
          Background = lib.cleanSource ../assets/wallpapers/current_wallpaper.jpg;
          ScreenWidth = 2560;
          ScreenHeight = 1440;
          FormPosition = "left";
          HaveFormBackground = true;
          PartialBlur = true;
          MainColor = colors.base0D;
          AccentColor = colors.base09;
          BackgroundColor = colors.base01;
          OverrideLoginButtonTextColor = colors.base05;
        };
      };
    };
  });
}

