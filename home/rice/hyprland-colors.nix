{ config, pkgs, ... }:

{
wayland.windowManager.hyprland.settings = {
    general = {
      shadow_offset = "0 5";
      "col.shadow" = config.stylix.colors.base00;
      "col.active_border" = config.stylix.colors.base03;
    };
};
}