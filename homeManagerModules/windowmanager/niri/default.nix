{ config, pkgs, lib, inputs, stylix, ... }: 

let
  system = pkgs.stdenv.system;
  niriPackages = inputs.niri-flake.packages.${system};
  xwaylandSatellitePkg = niriPackages.xwayland-satellite-unstable;
  electronWaylandEnv = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };
  stylixColors = if config.lib ? stylix then config.lib.stylix.colors.withHashtag else null;
  borderActiveColor = if stylixColors != null then stylixColors.base0D else "#5fafff";
  borderInactiveColor = if stylixColors != null then stylixColors.base03 else "#444444";
  focusRingActiveColor = if stylixColors != null then stylixColors.base0C else "#ccffff";
  focusRingInactiveColor = if stylixColors != null then stylixColors.base04 else "#888888";
  shadowColor = if stylixColors != null then stylixColors.base00 + "70" else "#00000070";
  # Noctalia IPC helper function
  noctalia = cmd: [
    "noctalia-shell" "ipc" "call"
  ] ++ (pkgs.lib.splitString " " cmd);
in

{

  options = {
    niri.enable = lib.mkEnableOption "Niri Window Manager";
  };

  config = lib.mkIf config.niri.enable {
    home.packages = [ xwaylandSatellitePkg ];
    programs.niri = {
      enable = true;
      settings =
        let
          actions = config.lib.niri.actions;
          workspaceRange = builtins.genList (x: x + 1) 10;
          keyFor = num: if num == 10 then "0" else builtins.toString num;
          workspaceFocusBinds = builtins.listToAttrs (map (num: {
            name = "Mod+" + keyFor num;
            value.action = actions.focus-workspace num;
          }) workspaceRange);
          workspaceMoveBinds = builtins.listToAttrs (map (num: {
            name = "Mod+Shift+" + keyFor num;
            value.action."move-column-to-workspace" = num;
          }) workspaceRange);
          baseEnv = {
            QT_IM_MODULE = "fcitx";
            XMODIFIERS = "@im=fcitx";
            SDL_IM_MODULE = "fcitx";
            GLFW_IM_MODULE = "ibus";
            INPUT_METHOD = "fcitx";
            QT_QPA_PLATFORM = "wayland";
            QT_QPA_PLATFORMTHEME = "kde";
            QT_STYLE_OVERRIDE = "kvantum";
            XDG_SESSION_TYPE = "wayland";
          };
          cursorEnv = lib.optionalAttrs config.cursor.enable (
            let
              cursorTheme = config.cursor.resolvedTheme;
              cursorSize = builtins.toString config.cursor.resolvedSize;
            in {
              XCURSOR_THEME = cursorTheme;
              XCURSOR_SIZE = cursorSize;
            }
          );
          hyprcursorEnv = lib.optionalAttrs (config.cursor.enable && config.cursor.resolvedHyprcursorTheme != null) (
            let
              hyprTheme = config.cursor.resolvedHyprcursorTheme;
              cursorSize = builtins.toString config.cursor.resolvedSize;
            in {
              HYPRCURSOR_THEME = hyprTheme;
              HYPRCURSOR_SIZE = cursorSize;
            }
          );
        in {
          environment = baseEnv // cursorEnv // hyprcursorEnv // electronWaylandEnv;

          xwayland-satellite = {
            enable = true;
            path = lib.getExe xwaylandSatellitePkg;
          };

          outputs = {
            "DP-1" = {
              mode = {
                width = 2560;
                height = 1440;
                refresh = 179.952;
              };
              position = {
                x = 1920;
                y = 0;
              };
              scale = 1.0;
            };
            "DP-2" = {
              mode = {
                width = 1920;
                height = 1080;
                refresh = 144.001;
              };
              position = {
                x = 4480;
                y = 194;
              };
              scale = 1.0;
            };
            "DP-3" = {
              mode = {
                width = 1920;
                height = 1080;
                refresh = 144.001;
              };
              position = {
                x = 0;
                y = 194;
              };
              scale = 1.0;
            };
            "DP-4" = {
              mode = {
                width = 2560;
                height = 1440;
                refresh = 179.95;
              };
              position = {
                x = 1920;
                y = 0;
              };
              scale = 1.0;
            };
            "DP-5" = {
              mode = {
                width = 1920;
                height = 1080;
                refresh = 144.0;
              };
              position = {
                x = 4480;
                y = 194;
              };
              scale = 1.0;
            };
            "DP-6" = {
              mode = {
                width = 1920;
                height = 1080;
                refresh = 144.0;
              };
              position = {
                x = 0;
                y = 194;
              };
              scale = 1.0;
            };
          };

          input = {
            mod-key = "Super";
            keyboard = {
              numlock = true;
              repeat-delay = 250;
              repeat-rate = 35;
              xkb.layout = "de";
            };
            mouse.natural-scroll = false;
            touchpad = {
              natural-scroll = false;
              tap = true;
              middle-emulation = true;
              click-method = "clickfinger";
            };
            focus-follows-mouse.enable = true;
          };

          layout = {
            border = {
              enable = true;
              width = 1;
              active.color = borderActiveColor;
              inactive.color = borderInactiveColor;
              };
            focus-ring = {
              enable = true;
              width = 2;
              active.color = focusRingActiveColor;
              inactive.color = focusRingInactiveColor;
            };
            shadow = {
              enable = true;
              offset = {
                x = 0.0;
                y = 2.0;
              };
              softness = 30.0;
              spread = 5.0;
              color = shadowColor;
            };
            gaps = 4;
          };

          animations = {
            enable = true;
          };

          spawn-at-startup = [
            { command = ["noctalia-shell"]; }
            { command = ["waybar"]; }
            { command = ["waypaper" "--restore"]; }
            { command = ["swww-daemon"]; }
            { command = ["fcitx5"]; }
            # Note: polkit agent is started via systemd service in environment.nix
            { sh = "sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"; }
            { command = ["swaync"]; }
            { command = ["wl-paste" "--type" "text" "--watch" "cliphist" "store"]; }
            { command = ["wl-paste" "--type" "image" "--watch" "cliphist" "store"]; }
            { command = ["thunderbird"]; }
            { command = ["discord"]; }
            { command = ["zen"]; }
            { command = ["arrpc"]; }
            { command = ["easyeffects"]; }
            { command = ["syncthing" "--no-browser"]; }
            { command = ["stable-diffusion-webui" "--listen"]; }
          ];

          window-rules = [
            {
              matches = [{ app-id = "(?i)org\\.wezfurlong\\.wezterm"; }];
              opacity = 0.7;
            }
            {
              matches = [
                { app-id = "(?i)pavucontrol"; }
                { app-id = "(?i)org\\.pulseaudio\\.pavucontrol"; }
              ];
              open-floating = true;
            }
            {
              matches = [{ app-id = "(?i)nm-connection-editor"; }];
              open-floating = true;
            }
            {
              matches = [{ app-id = "(?i)thunderbird"; }];
              open-on-workspace = "7";
            }
            {
              matches = [{ app-id = "(?i)discord"; }];
              open-on-workspace = "3";
            }
            {
              matches = [{ app-id = "(?i)easyeffects"; }];
              open-on-workspace = "9";
            }
            {
              matches = [{ app-id = "(?i)bitwarden"; }];
              open-floating = true;
            }
            {
              matches = [{ app-id = "(?i)org\\.freedesktop\\.impl\\.portal\\.desktop\\.kde"; }];
              open-floating = true;
            }
            {
              matches = [
                { app-id = "(?i)blueman-manager"; }
                { app-id = "(?i)blueberry"; }
              ];
              open-floating = true;
            }
            {
              matches = [{ app-id = "(?i)org\\.gnome\\.Calculator"; }];
              open-floating = true;
            }
            {
              matches = [
                { app-id = "(?i)mpv"; }
                { app-id = "(?i)com\\.github\\.rafostar\\.Clapper"; }
              ];
              open-floating = true;
            }
            {
              matches = [{ title = "(?i)Picture[-\\s]?in[-\\s]?Picture"; }];
              open-floating = true;
            }
            {
              matches = [
                { app-id = "(?i)steam"; title = "(?i)Steam Settings"; }
                { app-id = "(?i)steam"; title = "(?i)Friends List"; }
              ];
              open-floating = true;
            }
          ];

          binds =
            with actions;
            let
              shell = spawn "sh" "-c";
            in
            {
              ## Launchers & system
              "Mod+Space".action.spawn = noctalia "launcher toggle";
              "Mod+L".action.spawn = noctalia "lockScreen toggle";
              "Mod+P".action.spawn = noctalia "sessionMenu toggle";
              "Mod+Control+W".action = spawn "/etc/profiles/per-user/tinus/bin/switchwall";
              "Mod+N".action = spawn "swaync-client" "-t";
              "Mod+Alt+O".action = quit;
              "Mod+Shift+Alt+Q".action = quit { skip-confirmation = true; };

              ## Audio & brightness (Noctalia integration)
              "XF86MonBrightnessUp".action.spawn = noctalia "brightness increment";
              "XF86MonBrightnessDown".action.spawn = noctalia "brightness decrement";
              "XF86AudioRaiseVolume".action.spawn = noctalia "volume increase";
              "XF86AudioLowerVolume".action.spawn = noctalia "volume decrease";
              "XF86AudioMute".action.spawn = noctalia "volume muteOutput";
              "Alt+XF86AudioMute".action.spawn = noctalia "volume muteInput";
              "XF86AudioMicMute".action.spawn = noctalia "volume muteInput";
              "Mod+Shift+M".action.spawn = noctalia "volume muteOutput";
              "Mod+Alt+Y".action.spawn = noctalia "volume muteInput";

              ## Screenshots
              "Mod+Shift+S".action = shell "grim -g \"$(slurp)\" - | wl-copy";
              "Mod+Alt+S".action = shell "grim -g \"$(slurp)\" - | wl-copy";
              "Mod+Print".action = shell "grim - | wl-copy";

              ## Application shortcuts
              "Mod+T".action = spawn "wezterm";
              "Mod+E".action = spawn "nautilus";
              "Mod+B".action = spawn "zen";
              "Mod+C".action = spawn "code";
              "Mod+Control+V".action = spawn "pavucontrol";

              ## Window management
              "Mod+Q".action = actions.close-window;
              "Mod+X".action = actions.toggle-window-floating;
              "Mod+Shift+F".action = actions.fullscreen-window;
              "Mod+Alt+F".action = actions.toggle-windowed-fullscreen;
              "Mod+F".action = actions.maximize-column;

              ## Focus movement
              "Mod+Left".action = actions.focus-column-or-monitor-left;
              "Mod+Right".action = actions.focus-column-or-monitor-right;
              "Mod+Up".action = actions.focus-window-up;
              "Mod+Down".action = actions.focus-window-down;
              "Mod+BracketLeft".action = actions.focus-column-or-monitor-left;
              "Mod+BracketRight".action = actions.focus-column-or-monitor-right;

              ## Move windows
              "Mod+Shift+Left".action = actions.consume-or-expel-window-left;
              "Mod+Shift+Right".action = actions.consume-or-expel-window-right;
              "Mod+Shift+Up".action = actions.move-window-up;
              "Mod+Shift+Down".action = actions.move-window-down;

              ## Column sizing
              "Mod+Semicolon".action = actions.set-column-width "-10%";
              "Mod+Apostrophe".action = actions.set-column-width "+10%";

              ## Workspace navigation
              "Mod+Control+Right".action = actions.focus-workspace-down;
              "Mod+Control+Left".action = actions.focus-workspace-up;
              "Mod+Page_Down".action = actions.focus-workspace-down;
              "Mod+Page_Up".action = actions.focus-workspace-up;
              "Mod+Control+Page_Down".action = actions.focus-workspace-down;
              "Mod+Control+Page_Up".action = actions.focus-workspace-up;
              "Mod+WheelScrollDown".action = actions.focus-workspace-down;
              "Mod+WheelScrollUp".action = actions.focus-workspace-up;
              "Control+Mod+WheelScrollDown".action = actions.focus-workspace-down;
              "Control+Mod+WheelScrollUp".action = actions.focus-workspace-up;

              ## Monitor focus
              "Mod+Control+Alt+Right".action = actions.focus-monitor-right;
              "Mod+Control+Alt+Left".action = actions.focus-monitor-left;
            }
            // workspaceFocusBinds
            // workspaceMoveBinds;
        };
    };
  };
}
