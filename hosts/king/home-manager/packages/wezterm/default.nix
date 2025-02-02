{config, ...}: {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = ''
      local wezterm = require 'wezterm'

      return {
        -- Font settings
        font = wezterm.font("Meslo LGS NF"),
        font_size = 12.0,

        -- Color scheme
        color_scheme = "One Dark (Gogh)",

        -- Cursor settings
        default_cursor_style = "SteadyBar",
        cursor_thickness = 1.5,
        cursor_blink_rate = 666, -- 1.5 seconds in milliseconds
        cursor_blink_ease_in = "Linear",
        cursor_blink_ease_out = "Linear",

        -- Scrollback
        scrollback_lines = 10000,

        -- Mouse settings
        mouse_bindings = {
          {
            event = { Down = { streak = 1, button = "Middle" } },
            mods = "NONE",
            action = wezterm.action.PasteFrom("PrimarySelection"),
          },
        },

        -- URLs
        hyperlink_rules = {
          -- Linkify things that look like URLs and the host has a TLD name.
          {
            regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
            format = "$0",
          },
        },

        -- Window layout
        initial_cols = 128,
        initial_rows = 30,

        -- Tab bar
        tab_bar_at_bottom = false,
        use_fancy_tab_bar = true,

        -- Additional settings
        hide_mouse_cursor_when_typing = true,
        default_prog = { "zsh", "--login", "-c", "fastfetch; zsh" },

        -- Key bindings (you may want to customize these)
        keys = {
          -- Add your custom key bindings here
        },
      }
    '';
  };
}
