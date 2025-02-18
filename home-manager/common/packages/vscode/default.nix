{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
  ];
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-marketplace; [
      kamadorueda.alejandra
      bierner.emojisense
      aaron-bond.better-comments
      jeff-hykin.better-nix-syntax
      jeff-hykin.better-shellscript-syntax
      alefragnani.bookmarks
      naumovs.color-highlight
      bmalehorn.vscode-fish
      mhutchie.git-graph
      donjayamanne.githistory
      codezombiech.gitignore
      oderwat.indent-rainbow
      pkief.material-icon-theme
      jnoortheen.nix-ide
      aleksa-codes.one-dark-modern-pro
      ibm.output-colorizer
      mechatroner.rainbow-csv
      timonwong.shellcheck
      gruntfuggly.todo-tree
      redhat.vscode-yaml
    ];
    mutableExtensionsDir = true;
    userSettings = {
      "workbench.colorTheme" = "One Dark Modern Pro";
      "workbench.iconTheme" = "material-icon-theme";
      editor = {
        "fontFamily" = "FiraCode Nerd Font Mono";
        "fontWeight" = "600";
        "wordWrap" = "on";
        "formatOnPaste" = true;
        "formatOnSave" = true;
        "fontLigatures" = true;
        "fontSize" = 15;
        "tabSize" = 2;
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
}
