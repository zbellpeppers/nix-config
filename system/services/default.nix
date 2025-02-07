{
  pkgs,
  config,
  ...
}: {
  imports = [
    # ./searx
  ];
  # Enables fwupd - CLI-based Firmware Updater
  services.fwupd.enable = true;

  # Ai Service
  services.ollama = {
    enable = true;
    host = "127.0.0.1";
    port = 11434;
    openFirewall = true;
    acceleration = "rocm";
    rocmOverrideGfx = "10.3.0";
  };
  # Open-WebUI - Web-based Interface
  services.open-webui = {
    enable = true;
    host = "127.0.0.1";
    port = 8080;
    openFirewall = true;
    stateDir = /var/lib/open-webui;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
      WEBUI_AUTH = "False";
    };
  };
  # Btrfs Services
  services.btrfs = {
    autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = [
        "/"
        "/home"
        "/nix"
        "/var"
        "/tmp"
      ];
    };
  };
}
