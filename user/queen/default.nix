{
  pkgs,
  config,
  ...
}: {
  users.users.sarah = {
    isNormalUser = true;
    description = "Sarah Nicole Smallwood";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "samba"
      "i2c"
      "audio"
      "video"
      "nix"
      "lp"
      "scanner"
    ];
  };

  # SSH Configuration
  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      AddKeysToAgent yes
    '';
  };

  # Flatpak Declarative
  services.flatpak = {
    enable = true;
    update.onActivation = true;
    packages = [
    ];
  };
}
