{ pkgs, inputs }:
with pkgs;
{
  # Browsers
  librewolf          = librewolf-bin;
  zen-browser        = inputs.zen-browser.packages.${pkgs.system}.default;
  chromium           = ungoogled-chromium;

  # Communication
  vesktop            = vesktop;
  discord            = discord;
  thunderbird        = thunderbird;
  element-desktop    = element-desktop;
  teams              = teams-for-linux;
  goofcord           = goofcord;
  
  # Office & Productivity
  obsidian           = obsidian;
  vscode             = vscode-fhs;
  joplin             = joplin-desktop;
  kate               = kdePackages.kate;
  libreoffice        = libreoffice;
  office             = libreoffice-qt-still;
  
  # Media
  vlc                = vlc;
  mpv                = mpv;
  loupe              = loupe;
  spotify            = spotify;
  spicetify-cli      = spicetify-cli;
  
  # Graphics
  gimp               = gimp;
  inkscape           = inkscape;
  lact               = lact;

  # Cloud Storage
  nextcloud          = nextcloud-client;
  
  # Security
  bitwarden          = bitwarden-desktop;
  yubikey            = yubioath-flutter;
  ausweisapp         = ausweisapp;
  swaylock-fancy     = swaylock-fancy;
  
  # Audio
  easyeffects        = easyeffects;
  pavucontrol        = pavucontrol;
  pulseaudio         = pulseaudio;
  
  # File Management
  pcmanfm            = pcmanfm;
  nautilus           = nautilus;
  ark                = file-roller;
  syncthing          = syncthing;
  
  # Screenshot Tools
  satty              = satty;
  
  # System Tools
  nwg-displays       = nwg-displays;
  wdisplays          = wdisplays;
  way-displays       = way-displays;
  hyprlock           = hyprlock;
  swaynotificationcenter = swaynotificationcenter;
}
