{ config, pkgs, stylix, lib, inputs, ... }: {

  options = {
    hyprland.enable = lib.mkEnableOption "Hyprland Window Manager";
  };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      #plugins = [
      #  pkgs.hyprlandPlugins.hyprgrass
      #];

      settings = {

        source = [
          "monitors.conf"
          "workspaces.conf"
        ];
      

      general = {
          # Gaps and border
          gaps_in = 4;
          gaps_out = 5;
          gaps_workspaces = 50;

          border_size = 1;
          resize_on_border = true;

          no_focus_fallback = true;

          allow_tearing = true; # This just allows the `immediate` window rule to work

          snap.enabled = true;
      };

      #gestures = {
      #  workspace_swipe = true;
      #  workspace_swipe_cancel_ratio = 0.15;
      #};

      plugin = {
        touch_gestures = {
          workspace_swipe_gesture = 3;
          emulate_touchpad_swipe = true;
          
        };
      };

      bind = [
        # --- Launcher --- #
        "Super, Space, exec, pkill rofi || rofi -show drun" # Launcher
        # --- Hyprland System Stuff ---- #
        "Super+Alt, O, exec, hyprctl dispatch exit" # close Hyprland
        "Super, L, exec, hyprlock" # lock PC
        "Super+CTRL, W, exec, /etc/profiles/per-user/tinus/bin/switchwall" # Switch wallpaper
        "Super, N, exec, swaync-client -t" # Notification history

        #"Super, D, exec, ~/.config/nix-config/assets/scripts/show_desktop.sh"

        # --- Brightness and volume keys ---
        ", XF86MonBrightnessUp, exec, qs -c $qsConfig ipc call brightness increment || brightnessctl s 5%+" 
        ", XF86MonBrightnessDown, exec, qs -c $qsConfig ipc call brightness decrement || brightnessctl s 5%-" 
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+" 
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-" 
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle" 
        "Super+Shift, M, exec, wpctl set-mute @DEFAULT_SINK@ toggle" 
        "Alt, XF86AudioMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle" 
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle" 
        "Super+Alt, M, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle" 

        # --- Utilities ---
        "Super+Shift, S, exec, grimblast copy area | wl-copy"
        "Super+Alt, S, exec, grimblast save area | wl-copy"
        "Super, Print, exec, grimblast copy screen | wl-copy"
        "Super, M, exec, bash ~/.config/nix-config/scripts/dfsmount"

        ##! Apps
        "Super, T, exec, alacritty" # Terminal Emulator
        "Super, E, exec, pcmanfm" # File manager
        "Super, B, exec, zen" # Browser
        "Super, C, exec, code" # Code editor
        "Ctrl+Super, V, exec, pavucontrol" # Volume mixer
        #"Ctrl+Shift, Escape, exec, gnome-system-monitor" # Task manager
        "CTRL, Space, global, menu.kando.Kando:radial"

        # --- Window/Focus ---
        "Super, Q, killactive,"
        "Super+Shift+Alt, Q, exec, hyprctl kill" # Force kill
        "Super, X, togglefloating,"
        "Super, F, fullscreen, 1"
        "Super+Shift, F, fullscreen, 0"
        "Super+Alt, F, fullscreenstate, 0 3"
        "Super, P, pin"
        "Alt, Tab, cyclenext" 
        "Alt, Tab, bringactivetotop," 

        # Move focus (arrow keys)
        "Super, Left, movefocus, l"
        "Super, Right, movefocus, r"
        "Super, Up, movefocus, u"
        "Super, Down, movefocus, d"
        "Super, BracketLeft, movefocus, l" 
        "Super, BracketRight, movefocus, r" 

        # Move window (arrow keys)
        "Super+Shift, Left, movewindow, l"
        "Super+Shift, Right, movewindow, r"
        "Super+Shift, Up, movewindow, u"
        "Super+Shift, Down, movewindow, d"
        "Super+Shift, Q, killactive," 

        # Split ratio
        "Super, Semicolon, splitratio, -0.1" 
        "Super, Apostrophe, splitratio, +0.1" 

        # Workspace actions
        "Ctrl+Super, Right, workspace, r+1"
        "Ctrl+Super, Left, workspace, r-1"
        "Ctrl+Super+Alt, Right, workspace, m+1"
        "Ctrl+Super+Alt, Left, workspace, m-1"
        "Super, Page_Down, workspace, +1"
        "Super, Page_Up, workspace, -1"
        "Ctrl+Super, Page_Down, workspace, r+1"
        "Ctrl+Super, Page_Up, workspace, r-1"
        "Super, mouse_up, workspace, +1"
        "Super, mouse_down, workspace, -1"
        "Ctrl+Super, mouse_up, workspace, r+1"
        "Ctrl+Super, mouse_down, workspace, r-1"

        # Special Workspace actions
        "Super+Alt, Space, movetoworkspacesilent, special" # Send to scratchpad
        "Ctrl+Super, Space, togglespecialworkspace" 

      ]
      ++ (builtins.concatLists (builtins.genList (x:
        let
          num = x + 1;
          key = if num == 10 then "0" else builtins.toString num;
          ws = builtins.toString num;
          ws10 = if num == 10 then "10" else ws;
          ws0  = if num == 10 then "0"  else ws;
        in [
          # Super+Alt+N → movetoworkspacesilent N
          "Super+Alt, ${key}, movetoworkspacesilent, ${ws10}"
          # Super+Shift+N → movetoworkspace N
          "Super+Shift, ${key}, movetoworkspace, ${ws0}"
          # Super+N → workspace N
          "Super, ${key}, workspace, ${ws10}"
        ]
      ) 10));

      bindm = [
        "Super, mouse:272, movewindow" # Move
        "Super, mouse:274, movewindow" 
        "Super, mouse:273, resizewindow" # Resize
        # "Super ALT, mouse:272, resizewindow" # Only if you use it
      ];


      exec-once = [
        # wallpaper
        "waypaper --restore"
        "swww-daemon"

        # Input method
        "fcitx5"

        # Core components (authentication, lock screen, notification daemon)
        "lxqt-policykit-agent &"
        "sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "swaync"

        # Clipboard: history
        # wl-paste --watch cliphist store &
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"

        # Cursor
        "hyprctl setcursor Bibata-Modern-Classic 30"


        # Custom Programs
        "thunderbird"
        "element-desktop"
        "zen"
        "arrpc"
        "easyeffects"
        
      ];

      decoration = {
          rounding = 18;
          
          blur = {
              enabled = true;
              ignore_opacity = true;
              xray = true;
              special = false;
              new_optimizations = true;
              size = 14;
              passes = 3;
              brightness = 1;
              noise = 0.01;
              contrast = 1;
              popups = true;
              popups_ignorealpha = 0.6;
              input_methods = true;
              input_methods_ignorealpha = 0.8;
          };
          
          shadow = {
              enabled = true;
              ignore_window = true;
              range = 30;
              offset = "0 2";
              render_power = 4;
          };
      };

      dwindle = {
          preserve_split = true;
          smart_split = false;
          smart_resizing = false;
          # precise_mouse_move = true
      };

      bezier = [
          # Curves
          "expressiveFastSpatial, 0.42, 1.67, 0.21, 0.90"
          "expressiveSlowSpatial, 0.39, 1.29, 0.35, 0.98"
          "expressiveDefaultSpatial, 0.38, 1.21, 0.22, 1.00"
          "emphasizedDecel, 0.05, 0.7, 0.1, 1"
          "emphasizedAccel, 0.3, 0, 0.8, 0.15"
          "standardDecel, 0, 0, 0, 1"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.52, 0.03, 0.72, 0.08"
      ];

      animation = [
          # windows
          "windowsIn, 1, 3, emphasizedDecel, popin 80%"
          "windowsOut, 1, 2, emphasizedDecel, popin 90%"
          "windowsMove, 1, 3, emphasizedDecel, slide"
          "border, 1, 10, emphasizedDecel"
          # layers
          "layersIn, 1, 2.7, emphasizedDecel, popin 93%"
          "layersOut, 1, 2.4, menu_accel, popin 94%"
          # fade
          "fadeLayersIn, 1, 0.5, menu_decel"
          "fadeLayersOut, 1, 2.7, menu_accel"
          # workspaces
          "workspaces, 1, 7, menu_decel, slide"
          ## specialWorkspace
          "specialWorkspaceIn, 1, 2.8, emphasizedDecel, slidevert"
          "specialWorkspaceOut, 1, 1.2, emphasizedAccel, slidevert"
      ];

      input = {
          kb_layout = "de";
          numlock_by_default = true;
          repeat_delay = 250;
          repeat_rate = 35;

          follow_mouse = 1;

          touchpad = {
            natural_scroll = true;
            tap-to-click = true;
            middle_button_emulation = true;
            clickfinger_behavior = true;
          };
      };

      misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          vfr = 1;
          vrr = 1;
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
          animate_manual_resizes = false;
          animate_mouse_windowdragging = false;
          new_window_takes_over_fullscreen = 2;
          allow_session_lock_restore = true;
          initial_workspace_tracking = false;
          focus_on_activate = true;
      };

      binds = {
          scroll_event_delay = 0;
          hide_special_on_workspace_change = true;
      };


      cursor = {
          zoom_factor = 1;
          zoom_rigid = false;
      };

      env = [
        # ######### Input method ########## 
        # See https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
        "QT_IM_MODULE, fcitx"
        "XMODIFIERS, @im=fcitx"
        "SDL_IM_MODULE, fcitx"
        "GLFW_IM_MODULE, ibus"
        "INPUT_METHOD, fcitx"

        # ############ Themes #############
        "QT_QPA_PLATFORM, wayland"
        "QT_QPA_PLATFORMTHEME, kde"
        "QT_STYLE_OVERRIDE,kvantum"
        "WLR_NO_HARDWARE_CURSORS, 0"

        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,30"
      ];

      windowrule = [
        # ######## Window rules ########

        # Uncomment to apply global transparency to all windows:
        # windowrulev2 = opacity 0.89 override 0.89 override, class:.*



        # Kando
        "noblur, class:kando"
        "opaque, class:kando"
        "size 100% 100%, class:kando"
        "noborder, class:kando"
        "noanim, class:kando"
        "float, class:kando"
        "pin, class:kando"

        
        # Opacity 
        "opacity 0.7, class:^(Alacritty)$"

        # Floating
        "float, class:^(dunst)$"
        "float, class:^(blueberry\.py)$"
        "float, class:^(guifetch)$"   # FlafyDev/guifetch
        "float, class:^(pavucontrol)$"
        "size 45%, class:^(pavucontrol)$"
        "center, class:^(pavucontrol)$"
        "float, class:^(org.pulseaudio.pavucontrol)$"
        "size 45%, class:^(org.pulseaudio.pavucontrol)$"
        "center, class:^(org.pulseaudio.pavucontrol)$"
        "float, class:^(nm-connection-editor)$"
        "size 45%, class:^(nm-connection-editor)$"
        "center, class:^(nm-connection-editor)$"
        "float, class:.*plasmawindowed.*"
        "float, class:kcm_.*"
        "float, class:.*bluedevilwizard"
        "float, title:.*Welcome"
        "float, class:org.freedesktop.impl.portal.desktop.kde"
        "float, class:^(steam)$,title:^(Steam Settings)$"
        "float, class:^(steam)$,title:^(Friends List)$"
        "float, class:^(Bitwarden)$"
        "float, class:^(.blueman-manager-wrapped)$"

        "float, tag:notifications*"
        "float, tag:wallpaper*"
        "float, tag:settings*"
        "float, tag:viewer*"
        "float, class:(org.gnome.Calculator), title:(Calculator)"
        "float, class:^(mpv|com.github.rafostar.Clapper)$"
        "float, class:^([Qq]alculate-gtk)$"
        "float, class:^([Ff]erdium)$"
        "float, title:^(Picture-in-Picture)$"


        # Disable blur for xwayland context menus
        "noblur,class:^()$,title:^()$"

        # windowrule - ######### float popups and dialogue #######
        "float, title:^(Authentication Required)$"
        "center, title:^(Authentication Required)$"
        "float, class:(codium|codium-url-handler|VSCodium), title:negative:(.*codium.*|.*VSCodium.*)"
        "float, class:^(com.heroicgameslauncher.hgl)$, title:negative:(Heroic Games Launcher)"
        "float, class:^([Ss]team)$, title:negative:^([Ss]team)$"
        "float, class:([Tt]hunar), title:negative:(.*[Tt]hunar.*)"

        "float, title:^(Add Folder to Workspace)$"
        "size 70% 60%, title:^(Add Folder to Workspace)$"
        "center, title:^(Add Folder to Workspace)$"

        "float, title:^(Save As)$"
        "size 70% 60%, title:^(Save As)$"
        "center, title:^(Save As)$"

        "float, initialTitle:(Open Files)"
        "size 70% 60%, initialTitle:(Open Files)"
        # END of float popups and dialogue #######


        # Tiling
        # "tile, class:^dev\.warp\.Warp$"

        # Picture-in-Picture
        "float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
        "keepaspectratio, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
        "move 73% 72%, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
        "size 25%, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
        "float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
        "pin, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"

        # Dialog windows – float+center these windows.
        "center, title:^(Open File)(.*)$"
        "center, title:^(Select a File)(.*)$"
        "center, title:^(Choose wallpaper)(.*)$"
        "center, title:^(Open Folder)(.*)$"
        "center, title:^(Save As)(.*)$"
        "center, title:^(Library)(.*)$"
        "center, title:^(File Upload)(.*)$"
        "center, title:^(.*)(wants to save)$"
        "center, title:^(.*)(wants to open)$"
        "float, title:^(Open File)(.*)$"
        "float, title:^(Select a File)(.*)$"
        "float, title:^(Choose wallpaper)(.*)$"
        "float, title:^(Open Folder)(.*)$"
        "float, title:^(Save As)(.*)$"
        "float, title:^(Library)(.*)$"
        "float, title:^(File Upload)(.*)$"
        "float, title:^(.*)(wants to save)$"
        "float, title:^(.*)(wants to open)$"


        # --- Tearing ---
        "immediate, title:.*\.exe"
        "immediate, title:.*minecraft.*"
        "immediate, class:^(steam_app)"

        # No shadow for tiled windows (matches windows that are not floating).
        "noshadow, floating:0"

        # ######## Workspace rules ########
        # "special:special, gapsout:30"
      ];

      layerrule = [
        # ######## Layer rules ########
        # layerrule = xray 1, .*
        # layerrule = noanim, .*
        "noanim, walker"
        "noanim, selection"
        "noanim, overview"
        "noanim, anyrun"
        "noanim, indicator.*"
        "noanim, osk"
        "noanim, hyprpicker"

        "noanim, noanim"
        "blur, gtk-layer-shell"
        "ignorezero, gtk-layer-shell"
        "blur, launcher"
        "ignorealpha 0.5, launcher"
        "blur, notifications"
        "ignorealpha 0.69, notifications"
        "blur, logout_dialog # wlogout"

        # LAYER RULES
        "blur, rofi"
        "ignorezero, rofi"
        "blur, notifications"
        "ignorezero, notifications"


        # Launchers need to be FAST
        "noanim, gtk4-layer-shell"
      ];
      };
    };
  };
}
