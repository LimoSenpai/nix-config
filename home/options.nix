{ cofig, pkgs, ... }:

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
}