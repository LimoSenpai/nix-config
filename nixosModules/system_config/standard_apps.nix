
{ config, lib, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # Root Authentication
    lxqt.lxqt-sudo
    polkit_gnome

    # Default Applications
    gsettings-desktop-schemas
    man-db

    # themes
    rose-pine-hyprcursor
    hicolor-icon-theme
    adwaita-icon-theme
  ];
  

  programs = {
    
    coolercontrol = {
      enable =  true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    
    zsh = {
      enable = true;
      shellAliases = {
        ls = "eza";
        cp = "cp -i";
        mv = "mv -i";
        rm = "rm -i";
      };
      interactiveShellInit = ''
        fastfetch
        if command -v starship >/dev/null 2>&1; then
          eval "$(starship init zsh)"
        fi
      '';
    };

    #fish = {
    #  enable = true;
    #  shellAliases = {
    #    ls = "eza";
    #  };
    #  interactiveShellInit = ''
    #    set -g fish_greeting ""
    #    fastfetch
    #    if type -q starship
    #      starship init fish | source
    #    end
    #  '';
    #};

    
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
      presets = [
        "nerd-font-symbols"
      ];
    };

    
    bat = {
      enable = true;
    };
    # idk was for Cirno I think
    nix-ld = {
      enable = true;
    };
    gdk-pixbuf = {
      modulePackages = [ pkgs.librsvg ];
    };
  };
}