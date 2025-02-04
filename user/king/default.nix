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
      "podman"
    ];
  };

  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.system}.default
  ];

  # SSH Configuration
  # programs.ssh = {
  #   startAgent = true;
  #   extraConfig = ''
  #     AddKeysToAgent yes
  #   '';
  # };
  # GPG configuration
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  # Flatpak Configuration
  services.flatpak = {
    enable = true;
    update.onActivation = true;
    packages = [
    ];
  };
}
