{ cofig, pkgs, lib, inputs, ... }:

{
  programs = {
    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = "0";
      };
    };
    # basic configuration of git, please change to your own
    git = {
      enable = true;
      userName = "Tinus Braun";
      userEmail = "brauntinus@gnetic.pro";
    };
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
      ];
  };
};


  # Waybar Systemd Service
  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar status bar";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
      RestartSec = 2;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}