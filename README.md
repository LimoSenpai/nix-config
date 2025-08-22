# 🏠 My NixOS Configuration

A comprehensive NixOS configuration with support for multiple hosts and environments, featuring modern Wayland compositors, custom packages, and modular organization.

## 🖥️ Host Systems

### `desktop-pc` (Primary Gaming/Desktop)
- **Hostname**: `nixos-desktop`
- **Target**: High-performance desktop with NVIDIA GPU
- **Kernel**: Linux 6.15 (stable for NVIDIA compatibility)
- **Primary WM**: Hyprland + Niri
- **Features**: Gaming setup, NVIDIA support, full desktop environment

### `MBP` (MacBook Pro)
- **Hostname**: `nixosMBP`
- **Target**: Apple MacBook Pro with T2 chip
- **Features**: Apple T2 hardware support, WiFi firmware, Sway + Hyprland
- **Special**: Custom firmware loading for Broadcom WiFi/Bluetooth

### `thinkcentre` (Work/Office)
- **Hostname**: `nixos-thinkcentre`
- **Target**: Office workstation with network/proxy configuration
- **Kernel**: Linux 6.16
- **Features**: University proxy setup, work drive mounting, corporate authentication

## 🚀 Quick Start

### Clone and Deploy
```bash
# Clone the configuration
git clone https://github.com/LimoSenpai/nix-config ~/.config/nix-config
cd ~/.config/nix-config

# Build and switch for your host
sudo nixos-rebuild switch --flake .#<hostname>

# Available hostnames:
# - nixos-desktop    (desktop-pc)
# - nixosMBP         (MBP) 
# - nixos-thinkcentre (thinkcentre)
```

### Home Manager
```bash
# Apply home-manager configuration
home-manager switch --flake .#tinus@<hostname>
```

## 🏗️ Architecture

### Directory Structure
```
├── assets/                 # Static assets (wallpapers, scripts, icons)
├── homeManagerModules/     # User-level configurations
├── hosts/                  # Per-host configurations
├── nixosModules/          # System-level modules
└── pkgs/                  # Custom package derivations
```

### Module Organization

#### NixOS Modules (`nixosModules/`)
- **`programs_cli/`** - Command-line applications and tools
- **`programs_gui/`** - GUI applications and desktop software  
- **`programs_gaming/`** - Gaming-related packages and Steam
- **`programs_work/`** - Work/productivity applications
- **`system_config/`** - Core system configuration (fonts, hardware, services)
- **`wm/`** - Window managers and desktop environments

#### Home Manager Modules (`homeManagerModules/`)
- **`programs_cli/`** - User CLI tools (git, foot, playerctl)
- **`programs_gaming/`** - User gaming applications  
- **`programs_gui/`** - User GUI applications (spicetify)
- **`windowmanager/`** - WM configurations and utilities

## 🎨 Desktop Environment

### Window Managers
- **Hyprland** - Primary Wayland compositor with animations
- **Niri** - Scrollable-tiling Wayland compositor  
- **Sway** - i3-compatible Wayland compositor
- **BSPWM** - Binary space partitioning window manager
- **GNOME** - Traditional desktop environment
- **KDE Plasma 6** - Modern Qt-based desktop

### Utilities & Theming
- **Display Manager**: SDDM with Sugar Candy theme
- **Status Bar**: Waybar with custom Hyprpuccin theme
- **App Launcher**: Rofi (Wayland) + Wofi
- **Notifications**: Dunst + SwayNotificationCenter
- **Wallpapers**: SWWW with Waypaper management
- **Cursor**: Bibata (custom Hyprcursor build)
- **Theming**: Stylix for system-wide consistency

## 📦 Custom Packages

### `cirno-downloader`
A custom game/media downloader with WebKit integration. Includes extensive library patching for compatibility.

### `bibata-hyprcursor` 
Custom build of Bibata cursor theme with Hyprcursor support for Hyprland.

### `rivalcfg`
SteelSeries Rival mouse configuration utility.

## 🎮 Gaming Setup

### Steam & Compatibility
- **Steam** with Proton support
- **GameMode** for performance optimization
- **Gamescope** for game session management
- **Wine** with Winetricks for Windows compatibility
- **Lutris** for game management
- **ProtonPlus** for Proton version management

### Gaming Tools
- **PrismLauncher** - Minecraft launcher
- **ARRPC** - Discord Rich Presence for games
- **AdwSteamGtk** - Modern Steam client theming

## 🛠️ Development Environment

### Languages & Tools
- **Git** with custom configuration
- **VS Code** with extensions
- **Development libraries**: GCC, Make, various language support
- **Terminals**: Alacritty, Foot (with SSH compatibility notes)

### System Monitoring
- **btop/htop** - System monitoring
- **nvtop** - GPU monitoring  
- **iotop/iftop** - I/O monitoring
- **lm_sensors** - Hardware sensors

## 🌐 Network & Security

### Authentication & VPN
- **WireGuard** support across all hosts
- **Kerberos** authentication for work environments
- **University proxy** configuration (thinkcentre)
- **SSH** with proper key management

### Security Tools
- **Bitwarden** - Password management
- **YubiKey** support
- **KeePass** backup solution
- **GnuPG** for encryption

## 🎵 Media & Productivity

### Audio
- **PipeWire** audio system
- **EasyEffects** for audio processing
- **Pavucontrol** for audio control
- **Playerctl** for media control integration

### Applications
- **Zen Browser** - Firefox-based browser
- **Discord/Vesktop** - Communication
- **Obsidian** - Note-taking
- **LibreOffice** - Office suite
- **Thunderbird** - Email client
- **Nextcloud** - Cloud storage

## 🔧 Configuration Features

### Modular Package Management
Each host uses a declarative package management system with categories:
- `enable = [ "package1" "package2" ]` - Enable predefined packages
- `extraPackages = [ pkgs.custom ]` - Add additional packages

### Example Configuration
```nix
nixos-apps-gui.enable = [
  "zen-browser"
  "pavucontrol" 
  "vesktop"
];
nixos-apps-gui.extraPackages = [
  pkgs.customApp
];
```

### Hardware-Specific Features
- **NVIDIA GPU** support with proper driver management
- **Apple T2** compatibility for MacBook Pro
- **Power management** with power-profiles-daemon
- **Bluetooth** with proper firmware loading

## 📚 External Dependencies

### Key Sources
- **Waybar Theme**: [Hyprpuccin](https://github.com/jamsnxs/hyprpuccin)
- **SDDM Theme**: [Sugar Candy Nix](https://gitlab.com/Zhaith-Izaliel/sddm-sugar-candy-nix)
- **Hyprland**: Latest from upstream
- **Niri**: Via niri-flake
- **Zen Browser**: Custom flake integration

### Required System Features
- **Flakes** enabled (`nix.settings.experimental-features`)
- **Unfree packages** allowed for proprietary software
- **Home Manager** for user-level configuration

## 🚨 Important Notes

### System State Version
All configurations use NixOS 25.05 as the base system version.

### Locale & Keyboard
- **Timezone**: Europe/Berlin
- **Locale**: English (US) with German regional settings
- **Keyboard**: German layout (de-latin1-nodeadkeys)
- **Console**: German keymap

### User Configuration
- **Username**: tinus (Tinus Braun)
- **Shell**: Zsh
- **Groups**: networkmanager, wheel, plugdev, ad-cifs (work)

---

*Last updated: August 2025*
