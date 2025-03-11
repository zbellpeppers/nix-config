{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    antidote = {
      enable = true;
      plugins = [
      ];
    };

    autosuggestion = {
      enable = true;
      strategy = ["history"];
    };

    enableCompletion = true;

    # History config
    history = {
      append = true;
      findNoDups = true;
      save = 10000;
      size = 10000;
    };

    # Init commands
    initExtra = "fastfetch";

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
    ];

    # Aliases
    shellAliases = {
      # Replace ls with eza
      ls = "eza -al --color=always --group-directories-first --icons";
      la = "eza -a --color=always --group-directories-first --icons";
      ll = "eza -l --color=always --group-directories-first --icons";
      lt = "eza -aT --color=always --group-directories-first --icons";
      "l." = "eza -a | grep -e '^\\.'";
      # Common use
      tarnow = "tar -acf";
      untar = "tar -zxvf";
      wget = "wget -c";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "......" = "cd ../../../../..";
      dir = "dir --color=auto";
      vdir = "vdir --color=auto";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      hw = "hwinfo --short";
      big = "expac -H M '%m\t%n' | sort -h | nl";
      please = "sudo";
      jctl = "journalctl -p 3 -xb";
      rip = "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl";
      upgit = "/home/zachary/nix-config/gitupdate.sh";
      garbage = "sudo nix-collect-garbage -d";
      upflake = "cd /home/zachary/nix-config && nix flake update";
    };

    syntaxHighlighting = {
      enable = true;
      highlighters = ["brackets"];
    };
  };
}
