{inputs, pkgs, lib, ... }:

{
  home.packages =  with pkgs; [
    rofi-wayland
    swww
    waypaper
    rose-pine-cursor
  ];

  programs = {
    waybar = {
      enable = true;
      systemd = {
          enable = false;
          target = "graphical-session.target";
        };
    };
  };

  
  systemd.user.services.swww = {
    Unit = {
      Description = "swww wallpaper daemon";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}

