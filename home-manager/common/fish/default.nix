{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "sponge";
        src = pkgs.fishPlugins.sponge.src;
      }
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
      {
        name = "getopts";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "getopts.fish";
          rev = "main";
          sha256 = "1z5jvqip1hx59cggj9fyzaqqpz5rrsdjb3kv6ha042pbd034a57n";
        };
      }
      {
        name = "puffer";
        src = pkgs.fishPlugins.puffer.src;
      }
      {
        name = "virtualfish";
        src = pkgs.fetchFromGitHub {
          owner = "justinmayer";
          repo = "virtualfish";
          rev = "main";
          sha256 = "0izqc80rixkqjvzszabq01mw2phxryf34i69m2ih921l43f9v2bs";
        };
      }
      {
        name = "abbreviationtips";
        src = pkgs.fetchFromGitHub {
          owner = "Gazorby";
          repo = "fish-abbreviation-tips";
          rev = "master";
          sha256 = "05b5qp7yly7mwsqykjlb79gl24bs6mbqzaj5b3xfn3v2b7apqnqp";
        };
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf.src;
      }
      {
        name = "colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages.src;
      }
    ];
    shellInit = ''
      # Set default editor (using Nix package path)
      set -gx EDITOR ${pkgs.micro}/bin/micro
      set -gx VISUAL ${pkgs.micro}/bin/micro

      # Format man pages with bat (ensure bat is installed via Nix)
      set -gx MANROFFOPT -c
      set -gx MANPAGER "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'"
    '';
    functions = {
      fish_greeting = "${pkgs.fastfetch}/bin/fastfetch";
    };
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
      jctl = "journalctl -p 3 -xb";
      upgit = "$HOME/nix-config/gitupdate.sh";
      garbage = "sudo nix-collect-garbage -d";
      upflake = "cd $HOME/nix-config && nix flake update";
      nixsearch = "nix search nixpkgs";
      upplasma = "$HOME/nix-config/update-plasmamanager.sh";

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
    interactiveShellInit = ''
      # Add ~/.local/bin to PATH if it exists
      if test -d "$HOME/.local/bin"
        if not contains -- "$HOME/.local/bin" $PATH
          set -p PATH "$HOME/.local/bin"
        end
      end

      # --- Settings for done plugin ---
      set -U __done_min_cmd_duration 10000
      set -U __done_notification_urgency_level low

      # --- Functions needed for !! and !$ history expansion ---
      function __history_previous_command
        switch (commandline -t)
        case "!"
          commandline -t $history[1]; commandline -f repaint
        case "*"
          commandline -i !
        end
      end

      function __history_previous_command_arguments
        switch (commandline -t)
        case "!"
          commandline -t ""
          commandline -f history-token-search-backward
        case "*"
          commandline -i '$'
        end
      end

      # --- Fish command history with timestamps ---
      function history
        builtin history --show-time='%F %T '
      end

      # --- Create backup of a file ---
      function backup --argument filename
        cp $filename $filename.bak
      end

      # --- Copy DIR1 DIR2 (Consider if standard cp -r suffices) ---
      function copy
        set count (count $argv | tr -d \n)
        if test "$count" = 2; and test -d "$argv[1]"
          set from (echo $argv[1] | string trim -r /) # Use fish's string command
          set to (echo $argv[2])
          command cp -r $from $to
        else
          command cp $argv
        end
      end
    '';
  };
}
