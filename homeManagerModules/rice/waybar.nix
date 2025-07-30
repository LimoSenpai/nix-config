{inputs, pkgs, lib, ... }:

{
  
  programs = {
    waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };
      settings = [
        {
          "layer" = "top";
          "height" = 47;
          "reload_style_on_change" = true;
          "modules-left" = [
            "hyprland/workspaces"
            "mpris"
            "gamemode"
            "privacy"
            "tray"
          ];
          "modules-center" = [
            "clock"
          ];
          "modules-right" = [
            "cpu"
            "memory"
            "pulseaudio"
            "power-profiles-daemon"
            "custom/poweroff"
          ];
          "custom/poweroff" = {
            format = "⏻";
            on-click = "wleave";
            interval = 3600;
          };
          "hyprland/workspaces" = {
            "format" = "<span size='small' font='normal Font Awesome 6 Free'>{icon}</span>";
            "on-click" = "activate";
            "sort-by-number" = true;
            "on-scroll-up" = "hyprctl dispatch workspace e-1";
            "on-scroll-down" = "hyprctl dispatch workspace e+1";
            "format-icons" = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
            };
          };
          "mpris" = {
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
          "gamemode" = {
            "format" = "{glyph}";
            "format-alt" = "{glyph} {count}";
            "glyph" = "";
            "hide-not-running" = true;
            "use-icon" = true;
            "icon-name" = "input-gaming-symbolic";
            "icon-spacing" = 4;
            "icon-size" = 20;
            "tooltip" = true;
            "tooltip-format" = "Games running: {count}";
          };
          "privacy" = {
            "icon-spacing" = 4;
            "icon-size" = 12;
            "transition-duration" = 250;
            "modules" = [
              {
                "type" = "screenshare";
                "tooltip" = true;
                "tooltip-icon-size" = 12;
              }
              {
                "type" = "audio-in";
                "tooltip" = true;
                "tooltip-icon-size" = 12;
              }
            ];
          };
          "clock" = {
            "interval" = 1;
            "format" = " {:%d.%m.%Y | %H:%M}  ";
            "tooltip" = false;
            "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          };
          "tray" = {
            "icon-size" = 15;
            "spacing" = 10;
          };
          "cpu" = {
            "interval" = 1;
            "format" = " {usage}%";
            "max-length" = 10;
          };
          "memory" = {
            "interval" = 30;
            "format" = " {used:0.1f} GB";
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
          "pulseaudio" = {
            "format" = "{icon} {volume}% {format_source}";
            "format-bluetooth" = "{volume}% {icon}";
            "format-muted" = "󰖁 0% {format_source}";
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
      }
      ];
      style = ''
        * {
            font-family: "JetBrainsMono Nerd Font Propo";
            font-weight: bold;
            font-size: 14px;
            min-height: 0;
        }

        window#waybar {
            background: transparent;
            /* main window transparent background */
        }

        tooltip {
            font-family: inherit;
            background: @base00;
            /* tooltip background */
            border: 2px solid @base0D;
            /* tooltip border size and color */
            border-radius: 5px;
            /* tooltip rounded corners */
        }

        #workspaces button,
        #mpris,
        #privacy-item,
        #bluetooth,
        #clock,
        #tray,
        #cpu,
        #power-profiles-daemon,
        #memory,
        #pulseaudio,
        #gamemode,
        #custom-updates,
        #custom-poweroff {
            /*text-shadow: 1px 1px 2px @base00;*/
            /* text shadow, offset-x | offset-y | blur-radius | color */
            background: alpha(@base00, 0.5);
            /* background color */
            margin: 10px 4px 4px 4px;
            /* empty spaces around */
            padding: 4px 10px;
            /* extend pill size, vertical then horizontal */
            box-shadow: 1px 1px 2px 1px @base01;
            /* pill background shadows */
            border-radius: 8px; /*Default 5*/
            /* rounded corners */
            color: @base05;
        }

        #custom-poweroff:hover {
          background: alpha(@base08, 0.5);
          border-radius: 5px;
        }

        /* extend empty space on both side of the bar,
        * value from ~/.config/hypr/hyprland.conf
        * gaps_out (8px) + border size (2px) = 10px */

        #clock {
            padding-right: 5px;
        }

        #privacy-item {
            background: @base08;
            color: @base05;
        }

        /**#tray menu {
            font-weight: bold;
        }**/

        #workspaces {
            padding: 0 3px;
            /* remove padding around workspace module */
        }

        #workspaces button {
            padding: 0px 12px 0px 8px;
            /* fit with pill padding, 0px for not haveing duped vertical padding, 4px to make a square (4px value from module padding: ...#clock {padding >>4px<< 10px}) */
            margin-left: 3px;
            border: 1px solid transparent;
            transition-property:
                background-color, border-left-color, border-right-color;
            transition-duration: 0.1s;
            font-size: 10px;
            color: @base05;
        }

        #workspaces button.empty {
            padding: 0px 10px;
        }

        #workspaces button:first-child {
            margin-left: 0;
        }

        #workspaces button.active {
            /* active workspace */
            background: @base02;

        }

        #workspaces button:hover {
            background: alpha(@base08, 0.5);
            /* hovered workspace color */
        }

        #power-profiles-daemon {
            color: @base04;
        }

        @keyframes blink {
            to {
                background-color: @base08;
            }
        }

      '';
    };
  };
}

