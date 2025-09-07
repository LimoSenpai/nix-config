# Migration Guide: Moving from NixOS to Home Manager

## What Changed

### NixOS Modules (keep only system essentials):
- **programs_cli**: Only network tools requiring root, system monitoring, hardware-specific
- **programs_gui**: Only system tools, AMD tools if needed system-wide  
- **programs_gaming**: Only Steam tools that need system config
- **programs_work**: Only system authentication tools

### Home Manager Modules (user applications):
- **programs_cli**: All CLI tools, development tools, text editors, etc.
- **programs_gui**: Browsers, media players, editors, communication apps
- **programs_gaming**: Game launchers, gaming tools (user-level)
- **programs_work**: Communication, office, security apps (user-level)

## Example Migration for desktop-pc

### In configuration.nix (REMOVE most packages, keep only):

```nix
#=============================================================================#
#                              GUI PROGRAMS                                  #
#=============================================================================#
nixos-apps-gui.enable = [
  # Keep only if needed system-wide
  "pavucontrol"  # Only if needed system-wide
  "mesa-demos"   # AMD tools (if using AMD)
  "radeon-profile" # AMD tools (if using AMD)
];

#=============================================================================#
#                              CLI PROGRAMS                                  #
#=============================================================================#
nixos-apps-cli.enable = [
  # Network Tools requiring root
  "nmap"
  "tcpdump" 
  "wireshark-cli"
  
  # System monitoring requiring system access
  "lm_sensors"
  "ethtool"
  "pciutils" 
  "usbutils"
  "nvtop"     # If using NVIDIA
  
  # Hardware specific (if using MacBook)
  # "tiny-dfr"
];

#=============================================================================#
#                            GAMING PROGRAMS                                 #
#=============================================================================#
nixos-apps-gaming.enable = [
  # Keep only Steam tools that need system config
  "adwsteamgtk"
  "protontricks"
];

# Keep these system services
steam.enable = true;
gamemode.enable = true;

#=============================================================================#
#                              WORK PROGRAMS                                 #
#=============================================================================#
nixos-apps-work.enable = [
  # System authentication only
  "krb5"
  "keyutils" 
  "cifs-utils"
  "lxqt-sudo"
  "polkit-gnome"
];
```

### In home.nix (ADD the user applications):

```nix
#=============================================================================#
#                              GUI PROGRAMS                                  #
#=============================================================================#
home-apps-gui.enable = [
  # Browsers
  "firefox"
  "zen-browser"
  "chromium"
  
  # Communication
  "vesktop"
  "discord"
  "thunderbird"
  "element-desktop"
  
  # Office & Productivity  
  "obsidian"
  "vscode" 
  "joplin"
  "kate"
  "libreoffice"
  
  # Media
  "vlc"
  "mpv"
  "loupe"
  
  # Graphics
  "gimp"
  "inkscape"
  
  # Security
  "bitwarden"
  "yubikey"
  "ausweisapp"
  
  # Audio
  "easyeffects"
  "swaynotificationcenter"
  
  # File Management
  "pcmanfm"
  "ark"
  
  # Screenshot
  "satty"
  
  # Cloud Storage
  "nextcloud"
];

#=============================================================================#
#                              CLI PROGRAMS                                  #
#=============================================================================#
home-apps-cli.enable = [
  # Version Control & Network (user-level)
  "git"
  "curl" 
  "wget"
  "openssh"
  
  # Text Editors
  "vim"
  "nano"
  
  # System Monitoring (user-level)
  "htop"
  "btop"
  "iotop"
  "iftop"
  
  # File Management
  "tree"
  "eza"
  "fzf"
  "rsync"
  
  # Archive Tools
  "unzip"
  "zip"
  "xz" 
  "p7zip"
  "gnutar"
  "zstd"
  
  # Development Tools
  "gcc"
  "gnumake"
  
  # System Tools
  "killall"
  "lsof"
  "strace"
  "file"
  "which"
  "evtest"
  
  # Text Processing
  "gnused"
  "gawk"
  "libxml2"
  
  # Security
  "gnupg"
  
  # System Information
  "fastfetch"
  "lshw"
  
  # Existing tools
  "yazi"
  "slurp"
  "grim"
  "mdadm"
  "tmux"
  "jq"
  "icu"
  "hyperfine"
  "rg"
  "pandoc"
];

#=============================================================================#
#                            GAMING PROGRAMS                                 #
#=============================================================================#
home-apps-gaming.enable = [
  # Gaming Platforms
  "lutris"
  "heroic"
  
  # Gaming Tools
  "gamescope"
  "mangohud"
  
  # Emulators
  "retroarch"
  
  # Minecraft
  "prismlauncher"
  
  # Custom packages
  "cirno-downloader"
  
  # Discord Rich Presence
  "arrpc"
  
  # Game Tools
  "protontricks"
  "protonplus"
  
  # Wine
  "wine"
  "winetricks"
];

#=============================================================================#
#                              WORK PROGRAMS                                 #
#=============================================================================#
home-apps-work.enable = [
  # Communication
  "thunderbird"
  "element"
  
  # Security
  "keepass"
  
  # Office  
  "libreoffice"
  "onenote"
  
  # Network/Authentication (user-level)
  "geteduroam"
];
```

## Benefits of this migration:

1. **User-specific**: Applications install per-user, not system-wide
2. **Cleaner system**: System only has essential system tools
3. **Better isolation**: User apps don't require system rebuilds
4. **Faster rebuilds**: Home Manager rebuilds are faster than NixOS
5. **Per-user customization**: Different users can have different apps

## Next Steps:

1. Update your host configuration files following this pattern
2. Test with `sudo nixos-rebuild switch` and `home-manager switch`
3. Remove any duplicate packages in extraPackages that are now in registries
