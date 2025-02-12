{...}: {
  programs.rio = {
    enable = true;
    settings = {
      hide-cursor-when-typing = true;
      padding-x = 8;
      padding-y = [
        10
        5
      ];
      confirm-before-quit = false;

      colors = {
        background = "#282c34";
        foreground = "#dcdfe4";
        selection-background = "#474e5d";
        selection-foreground = "#dcdfe4";
        cursor = "#a3b3cc";
        black = "#282c34";
        red = "#e06c75";
        green = "#98c379";
        yellow = "#e5c07b";
        blue = "#61afef";
        magenta = "#c678dd";
        cyan = "#56b6c2";
        white = "#dcdfe4";
        light_black = "#282c34";
        light_red = "#e06c75";
        light_green = "#98c379";
        light_yellow = "#e5c07b";
        light_blue = "#61afef";
        light_magenta = "#c678dd";
        light_cyan = "#56b6c2";
        light_white = "#dcdfe4";
      };
      cursor = {
        shape = "beam";
        blinking = true;
        blinking-interval = 800;
      };

      editor = {
        program = "codium";
      };

      window = {
        width = 1110;
        height = 590;
        mode = "windowed";
        opacity = 1.0;
        blur = false;
        decorations = "enabled";
      };

      renderer = {
        performance = "High";
        backend = "Vulkan";
        disable-unfocused-render = false;
        level = 1;
      };

      fonts = {
        size = 16;

        regular = {
          family = "FiraCode Nerd Font Mono";
          style = "Normal";
          weight = 400;
        };
      };

      shell = {
        program = "/run/current-system/sw/bin/fish";
        args = ["--login"];
      };
    };
  };
}
