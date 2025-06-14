{
  pkgs,
  ...
}:
{
  imports = [
  ];
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-marketplace; [
        # Nix
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
        # Markdown support
        zaaack.markdown-editor
      ];
      userSettings = {
        # Editor
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.diagnosticLevel" = "information";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
            "options" = {
              "nixos" = {
                "expr" = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.king.options";
              };
              "home-manager" = {
                "expr" =
                  "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.king.options.home-manager.users.type.getSubOptions []";
              };
            };
          };
        };
        "editor.fontFamily" = "FiraCode Nerd Font Mono";
        "editor.fontWeight" = "600";
        "editor.wordWrap" = "on";
        "editor.formatOnSave" = true;
        "editor.fontLigatures" = true;
        "editor.fontSize" = 15;
        "editor.quickSuggestions" = {
          "comments" = "on";
          "strings" = "on";
        };
        "editor.snippetSuggestions" = "top";
        "editor.tokenColorCustomizations" = {
          textMateRules = [
            {
              scope = "comment";
              settings = {
                foreground = "#a0a0a0";
              };
            }
          ];
        };
        "editor.cursorStyle" = "line";
        "editor.overviewRulerBorder" = false;
        "editor.renderWhitespace" = "all";
        "editor.rulers" = [
          80
          120
        ];
        # Extensions
        "extensions.autoCheckUpdates" = true;
        "extensions.autoUpdate" = true;
        # Themes
        "workbench.colorTheme" = "One Dark Modern Pro";
        "workbench.iconTheme" = "material-icon-theme";
        # Git
        "git.enableSmartCommit" = true;
        "git.autofetch" = true;
        # Security
        "security.workspace.trust.untrustedFiles" = "open";
        # Telemetry
        "redhat.telemetry.enabled" = false;
      };
    };
  };
}
