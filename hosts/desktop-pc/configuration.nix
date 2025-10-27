# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use stable kernel for NVIDIA compatibility
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "nixos-desktop"; # Define your hostname.

  # User Configuration
  users.groups = {
    tinus = {};
    plugdev = {};
    media = {
      gid = 1500;
    };
  };

  users.users.tinus = {
    isNormalUser = true;
    description = "Tinus Braun";
    group = "tinus";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "media" ];
    shell = pkgs.zsh;
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "tinus";


  # WoL service now under `config`

  systemd.services."wol-enp12s0" = {
    description = "Enable Wake-on-LAN on enp12s0";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.ethtool}/sbin/ethtool -s enp12s0 wol g";
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 11434 7860 ];
    # optional: restrict to LAN only
    extraCommands = ''
      iptables -A nixos-fw -p tcp --dport 11434 -s 192.168.1.0/24 -j nixos-fw-accept
      iptables -A nixos-fw -p tcp --dport 7860 -s 192.168.1.0/24 -j nixos-fw-accept
    '';
  };



  services.ollama = {
    enable = true;
    acceleration = "cuda"; # options: "cuda", "rocm", "metal", or "none"
    host = "0.0.0.0";
    environmentVariables = {
      OLLAMA_LOW_VRAM = "false";
    };
  };

  # Ensure the md0 JBOD array is assembled before mounts run.
  systemd.services."mdadm-assemble-jbod" = {
    description = "Assemble md0 JBOD array";
    wantedBy = [ "local-fs.target" ];
    before = [ "mnt-jbod.mount" ];
    after = [ "systemd-udev-settle.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.writeShellScript "mdadm-assemble-jbod" ''
        set -eu
        ${pkgs.mdadm}/bin/mdadm --assemble --scan || true
        if [ -e /dev/md0 ]; then
          ${pkgs.mdadm}/bin/mdadm --manage /dev/md0 --run || true
        fi
      ''}";
    };
  };


  # Console and Localization
  console.keyMap = "de-latin1-nodeadkeys";
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #=============================================================================#
  #                            SYSTEM CONFIGURATION                            #
  #=============================================================================#
  
  # Window Managers
  hyprland.enable = true;
  niri.enable = true;
  #gnome.enable = true;
  #bspwm.enable = true;

  # Display Manager
  # In your host config:
  sddm.enable = true;

  noctalia.enable = true;

  # Hardware Support
  nvidia.enable = true;

  # System Services
  libnotify.enable = true;
  wleave.enable = true;
  dunst.enable = true;
  system-programs.enable = true;

  environment.systemPackages = [
    pkgs.stable-diffusion-webui.forge.cuda # For lllyasviel's fork of AUTOMATIC1111 WebUI
    pkgs.stable-diffusion-webui.comfy.cuda # For ComfyUI
  ];

  systemd.services.stable-diffusion-webui = {
    description = "Stable Diffusion WebUI (Forge)";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "nvidia-persistenced.service" ];
    wants = [ "network-online.target" ];

    # Needed tools
    path = [ pkgs.git pkgs.curl pkgs.bash ];

    environment = {
      HOME = "/var/lib/stable-diffusion-webui";
      PYTHONUNBUFFERED = "1";
    };

    preStart = ''
      ${pkgs.coreutils}/bin/mkdir -p /var/lib/stable-diffusion-webui/data
      ${pkgs.coreutils}/bin/mkdir -p /var/lib/stable-diffusion-webui/data/scripts

      ${pkgs.coreutils}/bin/cat <<'EOF' > /var/lib/stable-diffusion-webui/data/scripts/000_forge_space_overlay.py
      import hashlib
      import os
      import shutil

      from modules import script_callbacks
      from modules.paths_internal import data_path
      from modules_forge import forge_space

      _original_init = forge_space.ForgeSpace.__init__


      def _ensure_overlay(src: str) -> str:
          overlay_root = os.path.join(data_path, "forge-space-overlays")
          os.makedirs(overlay_root, exist_ok=True)

          digest = hashlib.sha1(src.encode("utf-8")).hexdigest()[:8]
          target_root = os.path.join(overlay_root, f"{os.path.basename(src)}-{digest}")

          shutil.copytree(src, target_root, dirs_exist_ok=True)
          return target_root


      def _retarget_space(space: forge_space.ForgeSpace) -> None:
          try:
              if os.access(space.root_path, os.W_OK):
                  return

              patched_root = _ensure_overlay(space.root_path)
              space.root_path = patched_root
              space.hf_path = os.path.join(patched_root, "huggingface_space_mirror")
          except Exception as exc:
              print(f"[forge-space-overlay] failed to prepare overlay for {space.root_path}: {exc}")


      def _patch_existing_spaces() -> None:
          for space in list(getattr(forge_space, "spaces", [])):
              _retarget_space(space)


      def _patched_init(self, root_path, *args, **kwargs):
          patched_root = root_path
          try:
              if not os.access(root_path, os.W_OK):
                  patched_root = _ensure_overlay(root_path)
          except Exception as exc:
              print(f"[forge-space-overlay] failed to prepare overlay for {root_path}: {exc}")
              patched_root = root_path

          _original_init(self, patched_root, *args, **kwargs)
          _retarget_space(self)


      def _on_before_ui() -> None:
          _patch_existing_spaces()


      def _on_app_started(*_args, **_kwargs) -> None:
          _patch_existing_spaces()


      forge_space.ForgeSpace.__init__ = _patched_init
      _patch_existing_spaces()
      script_callbacks.on_before_ui(_on_before_ui)
      script_callbacks.on_app_started(_on_app_started)
      EOF
    '';

  serviceConfig = {
    User = "root";
    Group = "root";

    # Important: run from a stable writable directory, not /tmp
    WorkingDirectory = "/var/lib/stable-diffusion-webui";
    StateDirectory = "stable-diffusion-webui";

    # Disable NixOS sandboxing that causes /tmp tmpdir relocation
    PrivateTmp = false;
    ProtectSystem = "off";
    ProtectHome = false;
    ReadWritePaths = [ "/var/lib/stable-diffusion-webui" ];

    # Restart behavior
    Restart = "always";
    RestartSec = 5;

    # Launch command
    ExecStart = lib.concatStringsSep " " [
      "${pkgs.stable-diffusion-webui.forge.cuda}/bin/stable-diffusion-webui"
      "--listen"
      "--api"
      "--enable-insecure-extension-access"
      "--xformers"
      "--cuda-malloc"
      "--cors-allow-origins http://localhost:5173"
      "--data-dir"
      "/var/lib/stable-diffusion-webui/data"
      "--gradio-allowed-path"
      "/var/lib/stable-diffusion-webui"
    ];
  };
};

  

  #=============================================================================#
  #                          SYSTEM ESSENTIAL PACKAGES                         #
  #=============================================================================#
  nixos-system-essentials.enable = [
    # Core system libraries
    "bluez"
    "glib"
    
    # Themes and icons
    "hicolor-icon-theme"
    "adwaita-icon-theme" 
    "gsettings-desktop-schemas"
    
    # Documentation
    "man-db"
    "man-pages"
    
    # Core utilities
    "coreutils"
    "util-linux"
    "findutils"
    
    # Audio libraries
    "alsa-lib"
    "alsa-utils"
    "pipewire"
    
    # Graphics libraries
    #"mesa"
    "vulkan-loader"
    
    # System libraries
    "systemd"
    "dbus"

    #Networking essentials
    "ethtool"
  ];
  nixos-system-essentials.extraPackages = [ 
  ];

  #=============================================================================#
  #                              GUI PROGRAMS                                  #
  #=============================================================================#
  nixos-apps-gui.enable = [
    # System audio (if needed system-wide)
    "pavucontrol"
    
    # System Tools requiring system access
    #"nwg-displays" #broken in unstable branch 25.11
    #"way-displays"
    "ark"
  ];
  nixos-apps-gui.extraPackages = [
    pkgs.wdisplays
    pkgs.firefox
    pkgs.linuxKernel.packages.linux_zen.ryzen-smu
    pkgs.ryzen-monitor-ng
    pkgs.bottles
  ];

  #=============================================================================#
  #                              CLI PROGRAMS                                  #
  #=============================================================================#
  nixos-apps-cli.enable = [
    # Network Tools requiring root
    "nmap"
    "tcpdump"
    #"wireshark-cli"
    
    # System monitoring requiring system access
    "lm_sensors"
    "ethtool"
    "pciutils"
    "usbutils"
    #"nvtop"
  ];
  nixos-apps-cli.extraPackages = [
    pkgs.webkitgtk_4_1
    pkgs.betterdiscordctl
  ];

  #=============================================================================#
  #                            GAMING PROGRAMS                                 #
  #=============================================================================#
  nixos-apps-gaming.enable = [
    # Steam Tools requiring system configuration
    "adwsteamgtk"
    "protontricks"
  ];
  nixos-apps-gaming.extraPackages = [
  ];
  
  # Gaming Options
  steam.enable = true;
  gamemode.enable = true;

  #=============================================================================#
  #                              WORK PROGRAMS                                 #
  #=============================================================================#
  nixos-apps-work.enable = [
    # System authentication tools
    #"krb5"
    #"keyutils"
    "cifs-utils"
    #"lxqt-sudo"  # Temporarily disabled due to Qt6 build issues
    "polkit-gnome"
  ];
  nixos-apps-work.extraPackages = [
  ];
  



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
