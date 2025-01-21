{
  pkgs,
  config,
  ...
}: {
  users.users.zachary = {
    isNormalUser = true;
    description = "Zachary Bell Peppers";
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
}
