{
  pkgs,
  config,
  ...
}: {
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
  services.nextjs-ollama-llm-ui.enable = true;
  # Open-WebUI - Web-based Interface
  # services.open-webui = {
  #   enable = true;
  #   openFirewall = true;
  #   stateDir = /var/lib/open-webui;
  #   environment = {
  #     ANONYMIZED_TELEMETRY = "False";
  #     DO_NOT_TRACK = "True";
  #     SCARF_NO_ANALYTICS = "True";
  #     LLAMA_CPP_SERVER_URL = "http://127.0.0.1:8080";
  #     WEBUI_AUTH = "False";
  #   };
  # };
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
