{ config, pkgs, ... }:

{
wayland.windowManager.hyprland.settings = {
    general = {
      shadow_offset = "0 5";
      "col.inactive_border" = config.stylix.colors.base01;
      "col.active_border" = config.stylix.colors.base08;
    };
};
}