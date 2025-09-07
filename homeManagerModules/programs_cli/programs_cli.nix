{ lib, pkgs, config, ... }:
let
  # Central registry: name -> package
  registry = with pkgs; {
    # Version Control & Network
    git                = git;
    curl               = curl;
    wget               = wget;
    openssh            = openssh;
    
    # Text Editors
    vim                = vim;
    nano               = nano;
    
    # System Monitoring
    htop               = htop;
    btop               = btop;
    iotop              = iotop;
    iftop              = iftop;
    sysstat            = sysstat;
    
    # File Management
    tree               = tree;
    eza                = eza; # A modern replacement for 'ls'
    fzf                = fzf; # A command-line fuzzy finder
    rsync              = rsync;
    yazi               = yazi;
    yaziPlugins-sudo   = yaziPlugins.sudo;
    
    # Archive Tools
    unzip              = unzip;
    zip                = zip;
    xz                 = xz;
    p7zip              = p7zip;
    gnutar             = gnutar;
    zstd               = zstd;
    
    # Development Tools
    gcc                = gcc;
    gnumake            = gnumake;
    
    # System Tools
    killall            = killall;
    lsof               = lsof;
    strace             = strace;
    file               = file;
    which              = which;
    evtest             = evtest;
    mdadm              = mdadm;
    tmux               = tmux;
    
    # Text Processing
    gnused             = gnused;
    gawk               = gawk;
    libxml2            = libxml2;
    jq                 = jq;
    icu                = icu;
    
    # Security
    gnupg              = gnupg;
    
    # System Information
    fastfetch          = fastfetch;
    lshw               = lshw; # List hardware information
    
    # Screenshot Tools
    grimblast          = grimblast; # Screenshot tool
    slurp              = slurp;
    grim               = grim;
    
    # Performance Tools
    hyperfine          = hyperfine;
    
    # Search
    rg                 = ripgrep;
    
    # Document Conversion
    pandoc             = pandoc;
    
    # Network Tools
    wireguard          = wireguard;
    
    # Terminal Emulator
    alacritty          = alacritty;
  };

  validNames = builtins.attrNames registry;
  cfg = config.home-apps-cli;
in
{
  options.home-apps-cli = {
    enable = lib.mkOption {
      type = lib.types.listOf (lib.types.enum validNames);
      default = [];
      example = [ "vesktop" "keepassxc" ];
      description = "List of registry apps to install.";
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Arbitrary extra packages not in the registry.";
    };
  };

  options ={
    alacritty.enable  = lib.mkEnableOption "Alacritty Terminal";
    git.enable = lib.mkEnableOption "Git version control";
    pinentry.enable = lib.mkEnableOption "Pinentry for GnuPG";
  };

  config = {
    home.packages =
      (map (name: registry.${name}) cfg.enable)
      ++ cfg.extraPackages;

    programs.alacritty = lib.mkIf config.alacritty.enable {
      enable = true;
    };

    programs.git = lib.mkIf config.git.enable {
      enable = true;
      userName = "Tinus Braun";
      userEmail = "brauntinus@gnetic.pro";
    };

  };
}
