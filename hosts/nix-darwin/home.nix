{ config, lib, pkgs, inputs, ... }:

{
  # The username and home directory for the user
  home.username = "tinus";
  home.homeDirectory = lib.mkForce "/Users/tinus";
  
  # Default Programs and Environment Variables
  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "code";
    TERMINAL = "alacritty";
    PATH = "$HOME/bin:$PATH";
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

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Tinus Braun";
    userEmail = "your.email@example.com";  # Replace with your email
  };

  # Shell configuration
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" "macos" ];
      theme = "robbyrussell";
    };
  };



  #=============================================================================#
  #                              USER PACKAGES                                 #
  #=============================================================================#
  home.packages = with pkgs; [
    # Tiling manager
    yabai

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
    bitwarden
    
    # Terminal utilities
    eza  # Better ls
    bat  # Better cat
        
    # Development
    nodejs
    python3
    go
    
    # Database tools
    dbeaver-bin
    
    # GUI Applications that work on Darwin
    vscode
    firefox-bin
    thunderbird
    obsidian
    bitwarden-desktop
    alacritty
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
