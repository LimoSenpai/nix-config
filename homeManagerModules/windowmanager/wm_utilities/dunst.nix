{ pkgs, lib, config, inputs, ...}: {

options = {
  dunst.enable = lib.mkEnableOption "Dunst Notification Daemon";
};

config = lib.mkIf config.dunst.enable {
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    settings = {
      global = {
        frame_color = "#89b4fa";
        highlight = "#89b4fa";
        rounded = "yes";
        origin = "top-right";
        alignment = "left";
            vertical_alignment = "center";
            width = "400";
            height = "400";
            scale = 0;
            gap_size = 0;
            progress_bar = true;
            transparency = 5;
            text_icon_padding = 0;
            sort = "yes";
            idle_threshold = 120;
            line_height = 0;
            markup = "full";
            show_age_threshold = 60;
            ellipsize = "middle";
            ignore_newline = "no";
            stack_duplicates = true;
            sticky_history = "yes";
            history_length = 20;
            always_run_script = true;
            corner_radius = 10;
            follow = "mouse";
            format = "<b>%s</b>\\n%b"; #format = "<span foreground='#f3f4f5'><b>%s %p</b></span>\n%b"
            frame_width = 1;
            offset = "15x15";
            horizontal_padding = 10;
            icon_position = "left";
            indicate_hidden = "yes";
            min_icon_size = 0;
            max_icon_size = 64;
            mouse_left_click = "do_action, close_current";
            mouse_middle_click = "close_current";
            mouse_right_click = "close_all";
          padding = 10;
          plain_text = "no";
          separator_height = 2;
          show_indicators = "yes";
          shrink = "no";
          word_wrap = "yes";
        };

        fullscreen_delay_everything = {fullscreen = "delay";};

      };
    };
  };
}