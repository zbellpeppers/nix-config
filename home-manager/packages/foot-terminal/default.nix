{...}: {
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        shell = "/run/current-system/sw/bin/zsh -c \"fastfetch; zsh\"";
        font = "Fira Code:size=13";
        dpi-aware = "yes";
        initial-window-size-pixels = "1080x560";
        pad = "10x10";
        resize-by-cells = "yes";
        resize-keep-grid = "yes";
        resize-delay-ms = "50";
      };
      environment = {
        EDITOR = "codium";
      };
      bell = {
        notify = "yes";
        visual = "yes";
      };
      scrollback = {
        lines = "10000";
      };
      cursor = {
        style = "beam";
        blink = "yes";
        blink-rate = "750";
        beam-thickness = "1.5";
      };
      mouse = {
        hide-when-typing = "no";
      };
      colors = {
        alpha = 1.0;
        background = "1e2127";
        foreground = "abb2bf";

        # Normal colors (0-7)
        regular0 = "1e2127"; # black
        regular1 = "e06c75"; # red
        regular2 = "98c379"; # green
        regular3 = "d19a66"; # yellow
        regular4 = "61afef"; # blue
        regular5 = "c678dd"; # magenta
        regular6 = "56b6c2"; # cyan
        regular7 = "abb2bf"; # white

        # Bright colors (8-15)
        bright0 = "5c6370"; # bright black
        bright1 = "e06c75"; # bright red
        bright2 = "98c379"; # bright green
        bright3 = "d19a66"; # bright yellow
        bright4 = "61afef"; # bright blue
        bright5 = "c678dd"; # bright magenta
        bright6 = "56b6c2"; # bright cyan
        bright7 = "ffffff"; # bright white

        # Selection colors
        selection-foreground = "1e2127";
        selection-background = "979eab";
      };
    };
  };
}
