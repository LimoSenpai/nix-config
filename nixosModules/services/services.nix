{ config, lib, pkgs, ... }:
let
  registry = {
    polkit-agent = {
      systemd.user.services.polkit-gnome-authentication-agent = {
        description = "PolicyKit Authentication Agent";
        wantedBy = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
        };
      };
    };

    smartcard = {
      services.pcscd.enable = true;
    };

    power-profiles-daemon = {
      services.power-profiles-daemon.enable = true;
    };

    storage-daemons = {
      services.udisks2.enable = true;
      services.gvfs.enable = true;
    };

    gnome-keyring = {
      services.gnome.gnome-keyring.enable = true;
    };

    bluetooth-manager = {
      services.blueman.enable = true;
      services.dbus.packages = [ pkgs.blueman ];
    };

    printing = {
      services.printing.enable = true;
    };

    lact = {
      services.lact.enable = true;
    };

    xserver = {
      services.xserver = {
        enable = lib.mkDefault true;
        xkb = {
          layout = lib.mkDefault "de";
          variant = lib.mkDefault "nodeadkeys";
        };
      };
    };

    openssh = {
      services.openssh = {
        enable = true;
        openFirewall = lib.mkDefault true;
        settings = {
          PubkeyAuthentication = lib.mkDefault true;
          PasswordAuthentication = lib.mkDefault true;
          PermitRootLogin = lib.mkDefault "yes";
        };
      };
    };

    sudo-poweroff = {
      security.sudo.enable = lib.mkDefault true;
      security.sudo.extraRules = lib.mkAfter [
        {
          users = [ "tinus" ];
          commands = [{
            command = "/run/current-system/sw/bin/systemctl poweroff";
            options = [ "NOPASSWD" ];
          }];
        }
      ];
    };

    ollama = {
      services.ollama = {
        enable = true;
        acceleration = "cuda";
        host = "0.0.0.0";
        environmentVariables.OLLAMA_LOW_VRAM = "false";
      };
    };

    stable-diffusion-webui = {
      environment.systemPackages = [
        pkgs.stable-diffusion-webui.forge.cuda
        pkgs.stable-diffusion-webui.comfy.cuda
      ];

      systemd.services.stable-diffusion-webui = {
        description = "Stable Diffusion WebUI (Forge)";
        wantedBy = [ "multi-user.target" ];
        after = [ "network-online.target" "nvidia-persistenced.service" ];
        wants = [ "network-online.target" ];
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
          WorkingDirectory = "/var/lib/stable-diffusion-webui";
          StateDirectory = "stable-diffusion-webui";
          PrivateTmp = false;
          ProtectSystem = "off";
          ProtectHome = false;
          ReadWritePaths = [ "/var/lib/stable-diffusion-webui" ];
          Restart = "always";
          RestartSec = 5;
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
    };
  };

  validNames = builtins.attrNames registry;
  defaultServices = validNames;

  cfg = config.nixos-services;
in
{
  options.nixos-services = {
    enable = lib.mkOption {
      type = lib.types.listOf (lib.types.enum validNames);
      default = defaultServices;
      example = [ "polkit-agent" "openssh" "sudo-poweroff" ];
      description = "Service bundles to enable.";
    };
  };

  config = lib.mkMerge (
    map (name: lib.mkIf (lib.elem name cfg.enable) registry.${name}) validNames
  );
}
