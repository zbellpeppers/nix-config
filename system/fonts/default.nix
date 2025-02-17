{
  config,
  pkgs,
  ...
}: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      roboto
      roboto-mono
      roboto-serif
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Roboto Serif"];
        sansSerif = ["Roboto"];
        monospace = ["Roboto Mono"];
      };
    };
  };
}
