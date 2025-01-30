# /etc/nixos/configuration.nix
{
  config,
  pkgs,
  ...
}: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      roboto
      liberation_ttf
      roboto-mono
      fira-code
    ];
  };
}
