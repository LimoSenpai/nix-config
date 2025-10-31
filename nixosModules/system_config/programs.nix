{ inputs, pkgs, lib, config, ... }: {

  options = {
    system-programs.enable = lib.mkEnableOption "System Programs";
  };

  config = lib.mkIf config.system-programs.enable {
      programs = {
      
      gnupg.agent.pinentryPackage = {
        enable = true;
      };
      
      coolercontrol = {
        enable =  true;
      };

      gpaste = {
        enable = true;
      };
      
      zsh = {
        enable = true;
        autosuggestions.enable = true;
        zsh-autoenv.enable = true;
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

        ohMyZsh = {
          enable = true;
          plugins = [
            "systemd"
            "sudo"
            "git"
            "man"
          ];
          customPkgs = [
            pkgs.zsh-history-substring-search
            pkgs.zsh-syntax-highlighting
            pkgs.nix-zsh-completions
          ];
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
        presets = [
          "jetpack" #pastel-powerline
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

  };
}

