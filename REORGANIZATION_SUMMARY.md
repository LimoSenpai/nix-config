# NixOS Modules Reorganization Summary

## What Changed

The `standard_apps.nix` file has been **removed** and all applications have been properly categorized into the existing modular structure.

## Application Categories & New Locations

### CLI Tools (`programs_cli`)
**Added to registry:**
- `eza` - Modern replacement for 'ls'
- `fzf` - Command-line fuzzy finder  
- `xz` - Compression utility
- `evtest` - Input device testing
- `iotop` - I/O monitoring
- `iftop` - Network interface monitoring
- `sysstat` - System performance tools
- `lm_sensors` - Hardware monitoring
- `ethtool` - Ethernet tool
- `pciutils` - PCI utilities (lspci, etc.)
- `usbutils` - USB utilities (lsusb, etc.)
- `gnutar` - GNU tar
- `zstd` - Compression utility
- `gnused` - GNU sed
- `gawk` - GNU awk
- `gnupg` - GNU Privacy Guard
- `btop` - Resource monitor
- `nvtop` - GPU monitor

### Work/Security Tools (`programs_work`)
**Added to registry:**
- `geteduroam` - eduroam configuration tool
- `lxqt-sudo` - GUI sudo tool
- `polkit-gnome` - PolicyKit authentication agent

### GUI Tools (`programs_gui`)
**Added to registry:**
- `ark` - KDE archive manager

### System Essentials (`system_config/system_essentials`)
**New module created for:**
- `bluez` - Bluetooth stack
- `glib` - Core library
- `hicolor-icon-theme` - Icon theme
- `adwaita-icon-theme` - GNOME icon theme
- `gsettings-desktop-schemas` - Desktop schemas
- `man-db` - Manual pages database

## How to Use the New Structure

### In your host configurations, replace:
```nix
standard-apps.enable = true;
```

### With:
```nix
system-essentials.enable = true;  # For core system packages
```

### And enable specific app categories as needed:
```nix
# CLI tools (add specific apps to the list)
nixos-apps-cli.enable = [
  "git" "wget" "btop" "eza" "fzf" "nvtop"
  # Add any others you need from the registry
];

# Work tools
nixos-apps-work.enable = [
  "geteduroam" "lxqt-sudo" "polkit-gnome"
  # Add others as needed
];

# GUI tools  
nixos-apps-gui.enable = [
  "ark"  # Archive manager
  # Add others as needed
];
```

## Benefits of the New Structure

1. **Modular**: Apps are organized by category and purpose
2. **Flexible**: Enable only what you need per host
3. **Extensible**: Easy to add new apps to appropriate registries
4. **Maintainable**: No more duplicate package definitions
5. **Clear separation**: CLI vs GUI vs Work vs Gaming apps

## Host Configuration Updates

All three host configurations have been automatically updated:
- `hosts/desktop-pc/configuration.nix` ✅
- `hosts/MBP/configuration.nix` ✅  
- `hosts/thinkcentre/configuration.nix` ✅

### Changes Made:
1. **Replaced** `standard-apps.enable = true;` with `system-essentials.enable = true;`
2. **Added all reorganized CLI tools** to `nixos-apps-cli.enable` lists
3. **Added archive manager** (`ark`) to `nixos-apps-gui.enable` lists  
4. **Added authentication tools** (`geteduroam`, `lxqt-sudo`, `polkit-gnome`) to `nixos-apps-work.enable` lists

### Programs Now Enabled by Default:
All programs from the old `standard_apps.nix` are now properly enabled in your host configurations and will be installed during rebuilds.

## Next Steps

You can now:
1. Review your host configurations and enable specific apps as needed
2. Remove apps you don't need from the enabled lists
3. Add new apps to the appropriate registry modules
4. Test the new configuration with `nixos-rebuild switch`
