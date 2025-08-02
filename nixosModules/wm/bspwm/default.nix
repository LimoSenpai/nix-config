{ inputs, pkgs, lib, config, stylix, ...}: with lib;{

  options = {
    bspwm.enable = lib.mkEnableOption "Niri";
  };

  config = lib.mkIf config.bspwm.enable {
    services.xserver = {
      enable = true;
      layout = "de";
      desktopManager.xfce = {
        enable = true;
        enableXfwm = false;
      };
      windowManager.bspwm.enable = true;
      #windowManager.bspwm.package = "pkgs.bspwm-unstable";
      #windowManager.default = "bspwm";
      #windowManager.bspwm.configFile = "/home/user/.config/nix-config/nixosModules/wm/bspwm/bspwmrc";
      #windowManager.bspwm.sxhkd.configFile= "/home/user/.config/nix-config/nixosModules/wm/bspwm/sxhkdrc";
      desktopManager.xterm.enable = false;

      #displayManager.lightdm = {
      #  enable = true;
      #  autoLogin.enable = true;
      # autoLogin.user = "user";
      #};
      #displayManager.auto = {
      #	enable = true;
      #	user = "user";
      #};
    };
    #services.xrdp.defaultWindowManager = "bspwm";
  };
}