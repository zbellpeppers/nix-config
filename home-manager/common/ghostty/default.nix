{...}: {
  programs.ghostty = {
    enable = true;
    # enableZshIntegration = true;
    enableFishIntegration = true;
    # See https://ghostty.org/docs/config/reference for config settings
    # Settings will me in the same order as the appear on the site above
    settings = {
      font-family = "FiraCode Nerd Font Mono";
      font-size = 11;
      theme = "Dracula+";
      adjust-cursor-thickness = 1;
      adjust-cursor-height = -3;
      cursor-style = "bar";
      cursor-style-blink = true;
      cursor-click-to-move = true;
      mouse-hide-while-typing = true;
      window-decoration = "auto";
      window-theme = "auto";
      window-height = 29;
      window-width = 120;
      clipboard-write = "ask";
      clipboard-trim-trailing-spaces = true;
      clipboard-paste-protection = true;
      confirm-close-surface = false;
      desktop-notifications = true;
    };
  };
}
