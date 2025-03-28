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
      # Format man pages
      set -x MANROFFOPT -c
      set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
    '';
    functions = {
      fish_greeting = "fastfetch";
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
    };
    interactiveShellInit = ''
      # Functions needed for !! and !$
      function __history_previous_command
        switch (commandline -t)
        case "!"
          commandline -t $history[1]
          commandline -f repaint
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

      # Fish command history
      function history
        builtin history --show-time='%F %T '
      end

      function backup --argument filename
        cp $filename $filename.bak
      end

      # Copy DIR1 DIR2
      function copy
        set count (count $argv | tr -d \n)
        if test "$count" = 2; and test -d "$argv[1]"
          set from (echo $argv[1] | trim-right /)
          set to (echo $argv[2])
          command cp -r $from $to
        else
          command cp $argv
        end
      end
    '';
  };
}
