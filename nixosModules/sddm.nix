{ config, pkgs, lib, ... }: 

  # I WASTED SO MUCH TIME HERE
  
let 
  colors = config.lib.stylix.colors.withHashtag;
in 
{  
services.displayManager.sddm = {
  enable = true; # Enable SDDM.
  sugarCandyNix = {
      enable = true; # This set SDDM's theme to "sddm-sugar-candy-nix".
      settings = {
        # Set your configuration options here.
        # Here is a simple example:
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
        # ...
      };
    };
  };
}

