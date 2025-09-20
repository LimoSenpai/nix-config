{ config, lib, pkgs, ... }:

{

  # Auto upgrade nix package  # This value determines the nix-darwin release with which your system is to be compatible
  # Do not change this value after initial setup.
  system.stateVersion = 6;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Set your system hostname
  networking.hostName = "mbp-darwin";  

  # Console and Localization
  time.timeZone = lib.mkDefault "Europe/Berlin";


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System settings
  system = {
    primaryUser = "tinus";
    # Configure keyboard
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;  # Optional: remap caps lock to escape
    };
    
    # Configure defaults
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "WhenScrolling";
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
      };

      dock = {
        autohide = true;
        orientation = "bottom";
        showhidden = true;
        tilesize = 40;
      };

      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
        FXEnableExtensionChangeWarning = false;
      };
    };
  };

  #=============================================================================#
  #                          SYSTEM PACKAGES                                  #
  #=============================================================================#
  environment.systemPackages = with pkgs; [
    # Core utilities
    coreutils
    findutils
    gnutar
    gzip
    wget
    curl
    git
    
    # System tools
    htop
    tree
    ripgrep
    fd
    
    # Development tools
    vim
    nano
    
    # Network tools
    nmap
    dig
    
    # macOS specific
    m-cli  # useful macOS CLI commands
    mas    # Mac App Store CLI
  ];

  # Activation script: make .app bundles visible to Spotlight by
  # symlinking them into /Applications and $HOME/Applications and running mdimport.
  system.activationScripts.spotlight-apps = {
    text = ''
      set -euo pipefail

  # Directories to scan for .app bundles. Avoid using a bash array
  # with shell-style expansions because Nix will try to interpret
  # them inside the multiline string. Use an explicit for loop below.

      target_system_apps="/Applications"
      target_user_apps="$HOME/Applications"

      mkdir -p "$target_system_apps" "$target_user_apps"

      link_app() {
        src="$1"
        name="$2"
        for tgt in "$target_system_apps" "$target_user_apps"; do
          dest="$tgt/$name"
          if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
            continue
          fi
          if [ -e "$dest" ] && [ ! -L "$dest" ]; then
            continue
          fi
          ln -sf "$src" "$dest"
          # Ask Spotlight to import the bundle so it becomes searchable
          if command -v mdimport >/dev/null 2>&1; then
            /usr/bin/mdimport -r "$src" || true
            /usr/bin/mdimport "$dest" || true
          fi
        done
      }

      # Cleanup dead symlinks
      find "$target_system_apps" "$target_user_apps" -maxdepth 1 -type l -print0 2>/dev/null | xargs -0 -r -n1 sh -c 'p="$0"; [ -e "$p" ] || rm -f "$p"' realpath

      for d in \
        "$HOME/.nix-profile/Applications" \
        "/run/current-system/sw/Applications" \
        "/nix/var/nix/profiles/per-user/$USER/profile/Applications" \
        "/nix/var/nix/profiles/default/share/applications" \
        "/nix/store"; do
        if [ "$d" = "/nix/store" ]; then
          find "$d" -maxdepth 2 -type d -name "*.app" -print0 2>/dev/null | while IFS= read -r -d "" app; do
            name="$(basename "$app")"
            link_app "$app" "$name"
          done
        else
          if [ -d "$d" ]; then
            find "$d" -maxdepth 3 -type d -name "*.app" -print0 2>/dev/null | while IFS= read -r -d "" app; do
              name="$(basename "$app")"
              link_app "$app" "$name"
            done
          fi
        fi
      done

      /usr/bin/touch "$target_system_apps"

    '';
  };

}
