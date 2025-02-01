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
    dockerCompat = true; # For Docker CLI compatibility
    dockerSocket.enable = true; # Required for Podman Desktop
  };
}
