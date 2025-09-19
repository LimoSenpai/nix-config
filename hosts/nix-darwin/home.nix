{ config, lib, pkgs, inputs, ... }:

{
  # The username and home directory for the user
  home.username = "tinus";
  home.homeDirectory = "/Users/tinus";
  
  # Default Programs and Environment Variables
  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "code";
    TERMINAL = "alacritty";
    PATH = "$HOME/bin:$PATH";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Web Browser - Zen Browser
      "text/html" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "x-scheme-handler/about" = "zen.desktop";
      "x-scheme-handler/unknown" = "zen.desktop";
      
      # File Manager - Nautilus
      "inode/directory" = "org.gnome.Nautilus.desktop";
      "application/x-gnome-saved-search" = "org.gnome.Nautilus.desktop";
      
      # Terminal - Alacritty
      "application/x-terminal-emulator" = "Alacritty.desktop";
    };
  };

  #=============================================================================#
  #                      MACOS SPECIFIC SETTINGS                              #
  #=============================================================================#

  # macOS specific configurations can be added here

  #=============================================================================#
  #                           ADDITIONAL PROGRAMS                              #
  #=============================================================================#
  
  #=============================================================================#
  #                           PROGRAM CONFIGURATION                           #
  #=============================================================================#
  
  # Terminal
  programs.alacritty = {
    enable = true;
    # Add your alacritty config here
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Tinus Braun";
    userEmail = "your.email@example.com";  # Replace with your email
  };

  # Shell configuration
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" "macos" ];
      theme = "robbyrussell";
    };
  };

  # Homebrew configuration (for macOS-specific packages)
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    taps = [
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/services"
    ];
    brews = [
      "mas"  # Mac App Store CLI
    ];
    casks = [
      "rectangle"  # Window management
      "alt-tab"    # Better Alt-Tab
      "keepingyouawake"  # Prevent sleep
    ];
  };

  #=============================================================================#
  #                              USER PACKAGES                                 #
  #=============================================================================#
  home.packages = with pkgs; [
    # Development tools
    git
    vim
    vscode
    gnumake
    gcc
    
    # CLI utilities
    curl
    wget
    tree
    ripgrep
    fd
    fzf
    jq
    yq
    tmux
    htop
    btop
    
    # Archive tools
    unzip
    zip
    gnutar
    
    # Text processing
    pandoc
    gnused
    gawk
    
    # Security
    gnupg
    bitwarden-cli
    
    # Terminal utilities
    eza  # Better ls
    bat  # Better cat
    
    # Cloud tools
    awscli2
    google-cloud-sdk
    
    # Development
    nodejs
    python3
    go
    
    # Database tools
    dbeaver
    
    # GUI Applications that work on Darwin
    vscode
    firefox
    chromium
    thunderbird
    obsidian
    vlc
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
