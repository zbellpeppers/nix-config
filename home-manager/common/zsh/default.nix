{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    antidote = {
      enable = true;
      plugins = [
        "Aloxaf/fzf-tab"
        "rupa/z"
        "MichaelAquilina/zsh-you-should-use"
        "zsh-users/zsh-completions"
        "wfxr/forgit"
        "chisui/zsh-nix-shell"
      ];
    };

    autosuggestion = {
      enable = true;
      strategy = [
        "completion"
        "history"
      ];
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
    initContent = "fastfetch";

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
      # Nix specific aliases
      nwhy = "nix-store --query --referrers"; # "Nix, why is this here?"
      nd = "nix develop"; # Nix Develop
      ns = "nix shell nixpkgs#"; # Nix Shell (e.g., ns python3)
      nixsearch = "nix search nixpkgs";
      upgit = "$HOME/nix-config/gitupdate.sh";
      garbage = "sudo nix-collect-garbage -d";
      upflake = "cd $HOME/nix-config && nix flake update";
      upplasma = "$HOME/nix-config/update-plasmamanager.sh";

      # Minecaft
      mc-server-up = "bash $HOME/.local/bin/launch-minecraft.sh";

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
      jctl = "journalctl -p 3 -xb";

      # Process memory usage
      psmem = "ps auxf | sort -nr -k 4";
      psmem10 = "ps auxf | sort -nr -k 4 | head -10";

      # System service management (System)
      scstat = "systemctl status";
      scstart = "sudo systemctl start";
      scstop = "sudo systemctl stop";
      screstart = "sudo systemctl restart";
      scenable = "sudo systemctl enable";
      scdisable = "sudo systemctl disable";
      screload = "sudo systemctl daemon-reload";

      # System service management (User)
      usys = "systemctl --user";
      uscstat = "systemctl --user status";
      uscstart = "systemctl --user start"; # No sudo needed for user services usually
      uscstop = "systemctl --user stop";
      uscrestart = "systemctl --user restart";
      uscenable = "systemctl --user enable";
      uscdisable = "systemctl --user disable";
      uscreload = "systemctl --user daemon-reload";

      # Safety features
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";

      # Network utilities (ensure curl, hostname, net-tools installed)
      myip = "${pkgs.curl}/bin/curl ifconfig.me";
      localip = "${pkgs.hostname}/bin/hostname -I";
      ports = "${pkgs.nettools}/bin/netstat -tulanp";

      # System info and maintenance
      df = "df -h";
      free = "free -h";
      diskspace = "du -S | sort -n -r | more"; # Ensure du, sort, more available
    };

    syntaxHighlighting = {
      enable = true;
      highlighters = [ "brackets" ];
    };
  };
}
