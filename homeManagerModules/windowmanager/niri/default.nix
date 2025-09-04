{ config, pkgs, lib, inputs, stylix, ... }: {

  options = {
    niri.enable = lib.mkEnableOption "Niri Window Manager";
  };

  config = lib.mkIf config.niri.enable {
    programs.niri = {
      settings = {
        
        environment = {
          QT_QPA_PLATFORM = "wayland";
          XDG_SESSION_TYPE = "wayland";
          QT_QPA_PLATFORMTHEME = "kde";
        };
        ## --- INPUT ---
        input = {
          mod-key = "Super";
          keyboard = {
            numlock = true;
            repeat-delay = 250;
            repeat-rate = 35;
            xkb.layout = "de";
          };
          mouse.natural-scroll = true;
          touchpad.natural-scroll = true;
          touchpad.tap = true;
        };

        ## --- LAYOUT ---
        layout = {
          border = {
            enable = true;
            width = 2;
            active.color = "#5fafff";
            inactive.color = "#444444";
          };
          focus-ring = {
            enable = true;
            width = 2;
            active.color = "#ccffff";
            inactive.color = "#888888";
          };
          gaps = 8;
        };

        ## --- ANIMATIONS ---
        animations.enable = true;

        ## --- STARTUP ---
        spawn-at-startup = [
          { command = ["waybar"]; }
          { command = ["fcitx5"]; }
          { command = ["dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP"]; }
        ];

        ## --- KEYBINDS ---
        binds = with config.lib.niri.actions; {
          ## --- LAUNCHERS ---
          "Mod+Space".action.spawn = ["rofi" "-show" "drun"];
          "Mod+Alt+O".action.spawn = ["hyprctl" "dispatch" "exit"];
          "Mod+Control+W".action.spawn = ["/etc/profiles/per-user/tinus/bin/switchwall"];

          ## --- BRIGHTNESS & VOLUME KEYS ---
          "XF86MonBrightnessUp".action.spawn = ["sh" "-c" "qs -c $qsConfig ipc call brightness increment || brightnessctl s 5%+"];
          "XF86MonBrightnessDown".action.spawn = ["sh" "-c" "qs -c $qsConfig ipc call brightness decrement || brightnessctl s 5%-"];
          "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "-l" "1" "@DEFAULT_AUDIO_SINK@" "2%+"];
          "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "2%-"];
          "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_SINK@" "toggle"];
          "Mod+Shift+M".action.spawn = ["wpctl" "set-mute" "@DEFAULT_SINK@" "toggle"];
          "Alt+XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_SOURCE@" "toggle"];
          "XF86AudioMicMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_SOURCE@" "toggle"];
          "Mod+Alt+M".action.spawn = ["wpctl" "set-mute" "@DEFAULT_SOURCE@" "toggle"];

          ## --- SCREENSHOT/UTILS ---
          "Mod+Shift+S".action.spawn = ["sh" "-c" "grimblast copy area | wl-copy"];
          "Mod+Print".action.spawn = ["sh" "-c" "grimblast copy screen | wl-copy"];

          ## --- APPS ---
          "Mod+T".action.spawn = ["alacritty"];
          "Mod+E".action.spawn = ["pcmanfm"];
          "Mod+B".action.spawn = ["zen"];
          "Mod+C".action.spawn = ["code"];
          "Mod+Control+V".action.spawn = ["pavucontrol"];

          ## --- WINDOW MANAGEMENT ---
          "Mod+Q".action.close-window = [];
          "Mod+Shift+Alt+Q".action.spawn = ["hyprctl" "kill"]; # closest, Niri doesn't have kill-active-window (force)
          #"Mod+X".action.toggle-float = [];
          #"Mod+F".action.toggle-fullscreen = [];
          # "Mod+Shift+F".action.toggle-fullscreen = []; # Niri doesn't have two fullscreen types, fallback to toggle
          # "Mod+Alt+F".action.toggle-fullscreen = [];
          #"Mod+P".action.pin = []; # Not directly available, may need a custom script

          # Alt+Tab is handled by Niri internally, but you can override:
          # "Alt+Tab".action.cycle-window = [];

          ## --- FOCUS ---
          #"Mod+Left".action.focus-left = [];
          #"Mod+Right".action.focus-right = [];
          #"Mod+Up".action.focus-up = [];
          #"Mod+Down".action.focus-down = [];
          #"Mod+BracketLeft".action.focus-left = [];
          #"Mod+BracketRight".action.focus-right = [];

          ## --- MOVE WINDOW ---
          #"Mod+Shift+Left".action.move-left = [];
          #"Mod+Shift+Right".action.move-right = [];
          #"Mod+Shift+Up".action.move-up = [];
          #"Mod+Shift+Down".action.move-down = [];

          ## --- SPLIT RATIO (not supported in Niri directly, but you can use 'resize' as workaround) ---
          # You could try to script this or use a similar resize action

          ## --- WORKSPACE ACTIONS ---
          #"Mod+Control+Right".action.next-workspace = [];
          #"Mod+Control+Left".action.prev-workspace = [];
          #"Mod+Page_Down".action.next-workspace = [];
          #"Mod+Page_Up".action.prev-workspace = [];

          # Mouse scroll for workspace switching
          #"Mod+ScrollUp".action.next-workspace = [];
          #"Mod+ScrollDown".action.prev-workspace = [];

          # SPECIAL WORKSPACE (Niri doesn't have scratchpad by default; needs a script or a patch!)
          # "Mod+Alt+Space".action.spawn = ["move-to-special-workspace-script"];
          # "Mod+Control+Space".action.spawn = ["toggle-special-workspace-script"];
        }
        // (
          # --- WORKSPACE KEYS (1-10) ---
          builtins.listToAttrs (builtins.genList (x:
            let
              num = x + 1;
              key = if num == 10 then "0" else builtins.toString num;
            in {
              name = "Mod+" + key;
              value.action.focus-workspace = num;
            }
          ) 10)
        );
        ## Optionally add more binds or use a helper for shift/alt combos if needed!

      };
    };
  };
}
