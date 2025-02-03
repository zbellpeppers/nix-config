{
  pkgs,
  config,
  ...
}: let
  llama-override =
    (pkgs.llama-cpp.overrideAttrs (finalAttrs: previousAttrs: {
      cmakeFlags = previousAttrs.cmakeFlags ++ ["-DGGML_HIP=ON"];
    }))
    .override {rocmSupport = true;};
in {
  # Enables fwupd - CLI-based Firmware Updater
  services.fwupd.enable = true;

  # Ai Service
  # services.ollama = {
  #   enable = true;
  #   acceleration = "rocm";
  #   rocmOverrideGfx = "10.3.0";
  # };
  # Ai Service
  services.llama-cpp = {
    enable = true;
    openFirewall = true;
    package = llama-override;
    model = "/home/zachary/Downloads/DeepSeek-R1-Distill-Llama-8B-Q8_0_1.gguf";
    extraFlags = [
      "-t"
      "16"
      "--gpu-layers"
      "35"
      "--mlock"
      "-c"
      "4096"
      "-m"
      "/home/zachary/Downloads/DeepSeek-R1-Distill-Llama-8B-Q8_0_1.gguf"
    ];
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
