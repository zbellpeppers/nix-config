{
  pkgs,
  config,
  inputs,
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

  # Flatpak Configuration
  services.flatpak = {
    enable = true;
    update.onActivation = true;
    packages = [
    ];
  };

  # AI
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    rocmOverrideGfx = "10.3.0";
  };
}
