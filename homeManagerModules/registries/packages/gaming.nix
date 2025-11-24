{ pkgs }:
with pkgs;
{
  # Gaming Platforms
  lutris             = lutris;
  heroic             = heroic;
  archipelago        = archipelago;
  archipelago-minecraft = archipelago-minecraft;
  
  # Gaming Tools
  gamemode           = gamemode;
  gamescope          = gamescope;
  mangohud           = mangohud;
  
  # Emulators
  retroarch          = retroarch;
  
  # Minecraft
  prismlauncher      = prismlauncher;
  
  # Custom packages
  cirno-downloader   = cirno-downloader;
  
  # Discord Rich Presence
  arrpc              = arrpc;
  
  # Game Tools
  protontricks       = protontricks;
  protonplus         = protonplus;
  adwsteamgtk        = adwsteamgtk;
  moonlight-qt       = moonlight-qt;
  sunshine           = sunshine;

  # Wine
  wine               = wine;
  winetricks         = winetricks;
}
