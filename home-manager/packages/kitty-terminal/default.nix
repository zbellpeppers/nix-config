{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "Meslo LGS NF";
      size = 12;
    };
    shellIntegration.enableZshIntegration = true;
    themeFile = "OneDark-Pro";
  };
}
