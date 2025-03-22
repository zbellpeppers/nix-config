{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-marketplace; [
        # Nix
        kamadorueda.alejandra
        jnoortheen.nix-ide
        jeff-hykin.better-nix-syntax
        # General
        bierner.emojisense
        aaron-bond.better-comments
        alefragnani.bookmarks
        naumovs.color-highlight
        oderwat.indent-rainbow
        ibm.output-colorizer
        mechatroner.rainbow-csv
        # Git
        mhutchie.git-graph
        donjayamanne.githistory
        codezombiech.gitignore
        gruntfuggly.todo-tree
        # Themes
        pkief.material-icon-theme
        aleksa-codes.one-dark-modern-pro
        # Language support
        redhat.vscode-yaml
        bmalehorn.vscode-fish
      ];
      userSettings = {
        "workbench.colorTheme" = "One Dark Modern Pro";
        "workbench.iconTheme" = "material-icon-theme";
        "redhat.telemetry.enabled" = false;
        "git.autofetch" = true;
        editor = {
          "fontFamily" = "FiraCode Nerd Font Mono";
          "fontWeight" = "600";
          "wordWrap" = "on";
          "formatOnSave" = true;
          "fontLigatures" = true;
          "fontSize" = 15;
          "quickSuggestions" = {
            "other" = true;
            "comments" = false;
            "strings" = true;
          };
          "snippetSuggestions" = "top";
          "tokenColorCustomizations" = {
            "textMateRules" = [
              {
                "scope" = "comment";
                "settings" = {
                  "foreground" = "#a0a0a0";
                };
              }
            ];
          };
          "cursorStyle" = "line";
          "overviewRulerBorder" = false;
          "renderWhitespace" = "all";
          "rulers" = [80 120];
          "minimap.enabled" = false;
        };
        "security.workspace.trust.untrustedFiles" = "open";
        "extensions.autoCheckUpdates" = true;
        "extensions.autoUpdate" = false;
      };
    };
  };
}
