{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "Fira Code";
      size = 12;
    };
    shellIntegration.enableZshIntegration = true;
    themeFile = "OneDark-Pro";
  };
}
