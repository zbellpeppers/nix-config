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
      add_newline = true;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      format = "$time $directory\n$character "; # Custom format for prompt
      time = {
        format = "🕙[\[ $time \]]($style) ";
        time_format = "%T";
      };
    };
  };
}
