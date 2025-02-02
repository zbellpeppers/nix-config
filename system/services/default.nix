{
  pkgs,
  config,
  ...
}: {
  # Enables fwupd - CLI-based Firmware Updater
  services.fwupd.enable = true;

  # AI
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    rocmOverrideGfx = "10.3.0";
  };
  # AI Container - Better UI than using Terminal
  virtualisation.podman = {
    enable = true;
    networkSocket.openFirewall = true;
    dockerCompat = true; # For Docker CLI compatibility
    dockerSocket.enable = true; # Required for Podman Desktop
  };
  # Open-WebUI - Web-based Interface
  services.open-webui = {
    enable = true;
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
}
