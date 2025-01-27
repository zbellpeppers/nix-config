{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "Meslo LGS NF";
      size = 11;
    };
    shellIntegration.enableZshIntegration = true;
    themeFile = "OneDark-Pro";
    settings = {
      # Cursor
      cursor_shape = "beam";
      cursor_beam_thickness = 1.5;
      cursor_blink_interval = 1.5;
      cursor_stop_blinking_after = 10;
      cursor_trail = 25;
      cursor_trail_start_threshold = 2;

      # Scrollback
      scrollback_lines = 10000;

      # Mouse
      mouse_hide_wait = 5.0;
      detect_urls = "yes";
      mouse_map = "middle release paste_from_selection";
      strip_trailing_spaces = "smart";

      # Performance Tuning
      sync_to_monitor = "yes";

      # Window Layout
      remember_window_size = "no";
      initial_window_width = 1080;
      initial_window_height = 560;

      # Tab Bar
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
    };
  };
}
