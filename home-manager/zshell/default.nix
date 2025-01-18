{pkgs, ...}: {
  # ZSH Configuration - ZSH is enabled system wide in /system/packages/default.nix
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      update = "/home/zachary/nix-config/update.sh";
    };
    history = {
      save = 10000;
    };
  };

  # Starship configuration + ZSH Integration
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "
        ┌───────────────────>](bold green)
        [│](bold green)$time$directory$rust$package
        [└─>](bold green) ";
      add_newline = true;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      time = {
        disabled = false;
        format = "[$time]($style)";
        use_12hr = true;
      };
    };
  };
}
