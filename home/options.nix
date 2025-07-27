{ cofig, pkgs, lib, inputs, ... }:

{
  programs = {
    kitty.enable = true;
    # basic configuration of git, please change to your own
    git = {
      enable = true;
      userName = "Tinus Braun";
      userEmail = "brauntinus@gnetic.pro";
    };
    fish = {
      enable = true;
      shellAliases = {
        ls = "eza";
      };
    };
      # starship - an customizable prompt for any shell
    starship = {
      enable = true;
      # custom settings
      settings = {
        add_newline = false;
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = true;
      };
    };
  };


  xdg = {
    enable = true;
      mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = [ "zen.desktop" ];
        "image/png" = [ "imv.desktop" ];
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "inode/directory" = [ "nautilus.desktop" ];
      };
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