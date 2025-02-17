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
        serif = ["Liberation Serif"];
        sansSerif = ["Liberation Sans"];
        monospace = ["Liberation Mono"];
      };
    };
  };
}
