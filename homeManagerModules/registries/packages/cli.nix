{ pkgs }:
with pkgs;
{
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
  eza                = eza;
  fzf                = fzf;
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
  cliphist           = cliphist;
  wl-copy            = wl-clipboard;
  
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
  lshw               = lshw;
  
  # Screenshot Tools
  grimblast          = grimblast;
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
  nftables           = nftables;
  
  # Terminal Emulator
  alacritty          = alacritty;
  wezterm            = wezterm;

  mpvpaper           = mpvpaper;
}
