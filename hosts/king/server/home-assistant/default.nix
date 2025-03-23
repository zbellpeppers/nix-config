{...}: {
  networking.firewall.allowedTCPPorts = [8123];
  services.home-assistant = {
    enable = true;
    extraPackages = python3Packages:
      with python3Packages; [
        isal
        aiohttp-fast-zlib
      ];
    extraComponents = [
      # Components required to complete the onboarding
      "esphome"
      "met"
      "radio_browser"
      "smartthings"
      "cloud"
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
      lovelace.mode = "storage";
    };
  };
}
