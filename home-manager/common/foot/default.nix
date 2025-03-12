{...}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        # shell = "$SHELL";
        term = "xterm-256color";

        # Font settings
        font = "FiraCode Nerd Font Mono:size=12";
        font-size-adjustment = "0.5";
        dpi-aware = "yes";

        # Window settings
        initial-window-size-chars = "120x29";
      };

      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
