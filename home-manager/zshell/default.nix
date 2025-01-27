{pkgs, ...}: {
  # ZSH Configuration - ZSH is enabled system wide in /system/packages/default.nix
  home.packages = [
    pkgs.zsh-powerlevel10k
    pkgs.meslo-lgs-nf
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    shellAliases = {
      upgit = "/home/zachary/nix-config/gitupdate.sh";
      update = "/home/zachary/nix-config/update.sh";
    };

    history = {
      save = 10000;
    };
  };
}
