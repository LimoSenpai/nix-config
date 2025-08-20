{ inputs, pkgs, lib, config, ... }: {
  
  options = {
    waybar.enable = lib.mkEnableOption "Waybar Status Bar";
  };

  config = lib.mkIf config.waybar.enable {
    stylix.targets.waybar.enable = true;
    programs = {
      waybar = {
        enable = true;
        systemd = {
          enable = false;
          target = "graphical-session.target";
        };
        settings = [
        {
            "layer" = "top"; # Waybar at top layer
            "position" = "top"; #Waybar position (top|bottom|left|right)
            "height" = 35; # Waybar height (to be removed for auto height)
            "spacing" = 4; # Gaps between modules (4px)
            "reload_style_on_change" = true;
            # Choose the order of the modules
            "modules-left" = [
                "custom/lframe"
                "hyprland/workspaces"
                "custom/rframe"
            #"custom/now-playing"
            ];
            "modules-center" = [
              "custom/now-playing"	
              "hyprland/window"
            ];
            "modules-right" = [
                #"mpd"
                #"idle_inhibitor"
                "power-profiles-daemon"
                "pulseaudio"
                #"network"
                "cpu"
                "memory"
                "temperature"
                #"hyprland/language"
                "clock"
                "tray"
                "custom/poweroff"
            ];
            # Modules configuration
            "hyprland/workspaces" = {
             "disable-scroll" = true;
              "all-outputs" = true;
              "warp-on-scroll" = false;
              "format" = "{icon}";
              "format-icons" = {
                "1" = "一";
                "2" = "二";
                "3" = "三";
                "4" = "四";
                "5" = "五";
                "6" = "六";
                "7" = "七";
                "8" = "八";
                "9" = "九";
                "10" = "十";
                "urgent" = "";
                "focused" = "";
                "default" = "";
              };
            };
            "custom/poweroff" = {
              "format" = "⏻";
              "on-click" = "wleave";
              "interval" = 3600;
            };
            "hyprland/scratchpad" = {
                "format" = "{icon} {count}";
                "show-empty" = false;
                "format-icons" = ["" ""];
                "tooltip" = true;
                "tooltip-format" = "{app} = {title}";
            };
            "mpd" = {
                "format" = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime =%M =%S}/{totalTime =%M =%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
                "format-disconnected" = "Disconnected ";
                "format-stopped" = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
                "unknown-tag" = "N/A";
                "interval" = 5;
                "consume-icons" = {
                    "on" = " ";
                };
                "random-icons" = {
                    "off" = "<span color=\"#f53c3c\"></span> ";
                    "on" = " ";
                };
                "repeat-icons" = {
                    "on" = " ";
                };
                "single-icons" = {
                    "on" = "1 ";
                };
                "state-icons" = {
                    "paused" = "";
                    "playing" = "";
                };
                "tooltip-format" = "MPD (connected)";
                "tooltip-format-disconnected" = "MPD (disconnected)";
            };
            "power-profiles-daemon" = {
              "format" = "{icon}";
              "tooltip-format" = "Power profile: {profile}\nDriver: {driver}";
              "tooltip" = true;
              "format-icons" = {
                "default" = "";
                "performance" = "";
                "balanced" = "";
                "power-saver" = "";
              };
            };
            "idle_inhibitor" = {
                "format" = "{icon}";
                "format-icons" = {
                    "activated" = "";
                    "deactivated" = "";
                };
            };
            "tray" = {
                # "icon-size" = 21;
                "spacing" = 10;
                # "icons" = {
                #   "blueman" = "bluetooth";
                #   "TelegramDesktop" = "$HOME/.local/share/icons/hicolor/16x16/apps/telegram.png"
                # }
            };
            "clock" = {
              "interval" = 1;
              "format" = " {:%d.%m.%Y | %H:%M}  ";
              "tooltip" = false;
              "tooltip-format" = "<tt><small>{calendar}</small></tt>";
            };
            "cpu" = {
                "format" = "{usage}% ";
                "tooltip" = false;
            };
            "memory" = {
                "format" = "{}% ";
            };
            "temperature" = {
                # "thermal-zone" = 2;
                "critical-threshold" = 80;
                "format" = "{temperatureC}°C";
                "format-icons" = ["" "" ""];
            };
            "network" = {
                # "interface" = "wlp2*"; // (Optional) To force the use of this interface
                "format-wifi" = "{essid} ({signalStrength}%) ";
                "format-ethernet" = "{ipaddr}/{cidr} ";
                "tooltip-format" = "{ifname} via {gwaddr} ";
                "format-linked" = "{ifname} (No IP) ";
                "format-disconnected" = "Disconnected ⚠";
                "format-alt" = "{ifname} = {ipaddr}/{cidr}";
            };
            "pulseaudio" = {
              "format" = "{icon}  {volume}%";
              "format-bluetooth" = " {volume}% {icon}";
              "format-muted" = "󰖁 0%";
              "format-icons" = {
                "headphone" = "";
                "hands-free" = "";
                "headset" = "";
                "phone" = "";
                "portable" = "";
                "car" = "";
                "default" = [
                  ""
                  ""
                ];
              };
              "scroll-step" = 5;
              "on-click" = "pavucontrol";
              "ignored-sinks" = [
                "Easy Effects Sink"
              ];
              "format-source" = "";
              "format-source-muted" = "";
            };
            # MEDIA PLAYERS (TEST)
            "custom/now-playing" = {
              "format" = "{player_icon}  {title} - {artist}";
              "format-paused" = "{status_icon}  {title} - {artist}";
              "max-length" = 50;
              "dynamic-len" = 10;
              #only the strings that match "spotify" will appear
              #"player" = "spotify";
              "on-scroll-up" = "playerctl --player=spotify volume 0.05+";
              "on-scroll-down" = "playerctl --player=spotify volume 0.05-";
              "player-icons" = {
                "default" = "󰎈";
                "mpv" = "";
                "vlc" = "<span color='#E85E00'>󰕼</span>";
                "spotify" = "<span color='#1DB954'></span>";
                "brave" = "<span font='normal Font Awesome 6 Free' color='#ed7009'></span>";
              };
              "status-icons" = {
                "paused" = "⏸";
                "playing" = "";
                "stopped" = "";
              };
            };

            "custom/lframe" = {
          "format" = "/";
            };
            "custom/rframe" = {
          "format" = "/";
            };
          

            "custom/playerctl" = {
              "format" = "{}";
              "return-type" = "json";
              "max-length" = 18;
              "exec" = "~/.config/waybar/scripts/playerctl_scroll.sh";
              "on-click" = "playerctl -i firefox previous";
              "on-click-right" = "playerctl -i firefox next";
              "on-click-middle" = "playerctl -i firefox play-pause";
              "on-scroll-up" = "playerctl -i firefox volume 0.05+";
              "on-scroll-down" = "playerctl -i firefox volume 0.05-";
            };
          }

        ];
        style = ''
          /* Override Stylix transparency - must come after the @define-color imports */
          window#waybar, tooltip {
            background: alpha(@base00, 0.5);
          }
          
          * {
            font-family: JetBrainsMono Nerd Font;
            padding: 0;
            margin: 0;
            border-radius: 0;
            border-color: @base0D;
          }


          /************************/
          /*  SPECIALS            */
          /************************/

          #custom-now-playing {
            color: @base05;
            font-weight: bold;
            padding: 0 10px;
          }

          #custom-lframe {
            padding: 0 0 0 10px;
          }

          #custom-rframe {
            padding: 0 10px 0 0;
          }

          /************************/
          /*  WORKSPACE BOTTONS   */
          /************************/

          /* i use special font and icon; please don't use this style. */
          #workspaces button {
            font-size: 28px;
            padding: 0 4px 0 4px;
            color: @base05;
            border: none;
          }

          #workspaces button:hover {
            color: @base0D;
            padding: 1px 4px 0 4px;
            border: none;
          }

          #workspaces button.active {
            color: @base0D;
            border: none;
          }

          #workspaces button.urgent {
            color: @base08;
            border: none;
          }



          /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
          /* a default css fix for GTK css */
          button:hover {
            box-shadow: none; /* Remove predefined box-shadow */
            text-shadow: none; /* Remove predefined text-shadow */
            transition: none; /* Disable predefined animations */
            border: none;
          }




          #idle_inhibitor,
          #cava,
          #scratchpad,
          #mode,
          #window,
          #clock,
          #battery,
          #backlight,
          #wireplumber,
          #tray,
          #mpris,
          #power-profiles-daemon,
          #custom-poweroff,
          #load {
            padding: 0 10px;
            /* color: @foreground; */

            color: @base05;
            font-weight: bold;
          }

          #custom-poweroff {
            padding-right: 20px;
          }

          #mode {
              /* color: @foreground; */

              color: @base05;
              font-weight: bold;
              padding: 0 10px;

              /* box-shadow: inset 0 -3px @base00; */
          }

        .modules-left #workspaces button.focused,
        .modules-left #workspaces button.active {
          border: 0;
        }

          /* If workspaces is the leftmost module; omit left margin 
          .modules-left > widget:first-child > #workspaces {
              margin-left: 0;
          }

           If workspaces is the rightmost module; omit right margin 
          .modules-right > widget:last-child > #workspaces {
              margin-right: 0;
          }
            */
          #cava {
              padding: 0 5px;
          }


          @keyframes blink {
              to {
                  background-color: @base00;
                  color: @base05;
              }
          }

          label:focus {
              background-color: @base00;
          }

          #wireplumber.muted {
              background-color: @base00;
          }

          #tray > .passive {
              -gtk-icon-effect: dim;
          }

          #tray > .needs-attention {
              -gtk-icon-effect: highlight;
          }

          #tray menu {
              font-family: sans-serif;
          }

          #scratchpad.empty {
              background: transparent;
          }

        '';
      };
    };

    # Custom Waybar Systemd Service with restart on failure
    systemd.user.services.waybar = {
      Unit = {
        Description = "Waybar status bar";
        After = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${pkgs.waybar}/bin/waybar";
        Restart = "on-failure";
        RestartSec = 2;
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}

