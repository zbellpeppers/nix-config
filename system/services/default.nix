{
  pkgs,
  config,
  ...
}: {
  # Enables fwupd - CLI-based Firmware Updater
  services.fwupd.enable = true;

  # Ai Service
  # services.ollama = {
  #   enable = true;
  #   acceleration = "rocm";
  #   rocmOverrideGfx = "10.3.0";
  # };
  # Ai Service
  # services.llama-cpp = {
  #   enable = true;
  #   openFirewall = true;
  #   extraFlags = [
  #     "-t"
  #     "16"
  #     "-ngl"
  #     "32"
  #     "-mli"
  #     "-c"
  #     "0"
  #     "--numa"
  #     "numactl"
  #   ];
  # };
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
      LLAMA_CPP_SERVER_URL = "http://127.0.0.1:8080";
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
