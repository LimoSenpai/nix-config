{ inputs, pkgs, lib, config, ... }: {

  options = {
    system-programs.enable = lib.mkEnableOption "System Programs";
  };

  config = lib.mkIf config.system-programs.enable {
      programs =
        let
          ohMyZshCustomPath = pkgs.linkFarm "oh-my-zsh-custom" [
            {
              name = "plugins/zsh-history-substring-search/zsh-history-substring-search.zsh";
              path = "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh";
            }
            {
              name = "plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
              path = "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
            }
            {
              name = "plugins/nix-zsh-completions";
              path = "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix-zsh-completions";
            }
            {
              name = "site-functions";
              path = "${pkgs.nix-zsh-completions}/share/zsh/site-functions";
            }
          ];
          ohMyZshCustom = toString ohMyZshCustomPath;
        in {
      
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
          custom = ohMyZshCustom;
          customPkgs = lib.mkForce [];
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

