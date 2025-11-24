{ pkgs, lib, config, ... }:
let
  stylixColors = if config.lib ? stylix then config.lib.stylix.colors.withHashtag else null;
  fallbackColors = {
    base00 = "#1a1b26";
    base01 = "#16161e";
    base02 = "#2f3549";
    base03 = "#444b6a";
    base04 = "#787c99";
    base05 = "#a9b1d6";
    base06 = "#cbccd1";
    base07 = "#d5d6db";
    base08 = "#f7768e";
    base09 = "#ff9e64";
    base0A = "#e0af68";
    base0B = "#9ece6a";
    base0C = "#7dcfff";
    base0D = "#7aa2f7";
    base0E = "#bb9af7";
    base0F = "#c53b53";
  };
  colors = if stylixColors != null then stylixColors else fallbackColors;
  stylixFonts = if config ? stylix && (config.stylix.fonts ? monospace)
    then config.stylix.fonts.monospace else null;
  fontFamily = if stylixFonts != null then stylixFonts.name else "Maple Mono";
  terminalOpacity = if config ? stylix && (config.stylix.opacity ? terminal)
    then config.stylix.opacity.terminal else 0.95;
in
{
  options.wezterm.enable = lib.mkEnableOption "WezTerm terminal";

  config = lib.mkIf config.wezterm.enable {
    home.packages = [ pkgs.wezterm ];

    xdg.configFile."wezterm/wezterm.lua".text = ''
local wezterm = require("wezterm")

local palette = {
  foreground = "${colors.base05}",
  background = "${colors.base00}",
  cursor_bg = "${colors.base05}",
  cursor_border = "${colors.base05}",
  cursor_fg = "${colors.base00}",
  selection_bg = "${colors.base05}",
  selection_fg = "${colors.base00}",
  ansi = {
      "${colors.base00}",
      "${colors.base08}",
      "${colors.base0B}",
      "${colors.base0A}",
      "${colors.base0D}",
      "${colors.base0E}",
      "${colors.base0C}",
      "${colors.base05}"
  },
  brights = {
      "${colors.base03}",
      "${colors.base08}",
      "${colors.base0B}",
      "${colors.base0A}",
      "${colors.base0D}",
      "${colors.base0E}",
      "${colors.base0C}",
      "${colors.base07}"
  },
  tab_bar = {
    background = "${colors.base00}",
    active_tab = {
      bg_color = "${colors.base0D}",
      fg_color = "${colors.base00}",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "${colors.base01}",
      fg_color = "${colors.base05}",
    },
    inactive_tab_hover = {
      bg_color = "${colors.base02}",
      fg_color = "${colors.base05}",
    },
    new_tab = {
      bg_color = "${colors.base01}",
      fg_color = "${colors.base05}",
    },
    new_tab_hover = {
      bg_color = "${colors.base02}",
      fg_color = "${colors.base05}",
      italic = true,
    },
  },
}

return {
  check_for_updates = false,
  enable_wayland = true,
  front_end = "WebGpu",
  color_scheme = "Stylix",
  color_schemes = { Stylix = palette },
  font = wezterm.font_with_fallback({
    "${fontFamily}",
    "Maple Mono",
    "Noto Sans CJK JP",
    "Noto Color Emoji",
  }),
  font_size = 11.0,
  line_height = 1.05,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  window_decorations = "RESIZE",
  window_background_opacity = ${toString terminalOpacity},
  macos_window_background_blur = 20,
  window_padding = {
    left = 8,
    right = 8,
    top = 6,
    bottom = 4,
  },
  adjust_window_size_when_changing_font_size = false,
  keys = {
    { key = "t", mods = "CTRL|SHIFT", action = wezterm.action{SpawnTab = "DefaultDomain"} },
    { key = "w", mods = "CTRL|SHIFT", action = wezterm.action{CloseCurrentTab = { confirm = true }} },
  },
}
'';
  };
}
