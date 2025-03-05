{
  pkgs,
  config,
  ...
}: {
  imports = [
  ];

  services = {
    # Enables fwupd - CLI-based Firmware Updater
    fwupd.enable = true;

    # Openrgb
    hardware.openrgb.enable = true;

    # Ai Service
    ollama = {
      enable = true;
      host = "0.0.0.0";
      port = 11434;
      openFirewall = true;
      acceleration = "rocm";
      rocmOverrideGfx = "10.3.0";
    };
    # Open-WebUI - Web-based Interface - CURRENTLY BROKEN
    open-webui = {
      enable = true;
      host = "0.0.0.0";
      port = 8080;
      openFirewall = true;
      stateDir = /var/lib/open-webui;
      environment = {
        ANONYMIZED_TELEMETRY = "False";
        DO_NOT_TRACK = "True";
        SCARF_NO_ANALYTICS = "True";
        WEBUI_URL = "http://0.0.0.0:8080";
        ENABLE_REALTIME_CHAT_SAVE = "True";
        OLLAMA_API_BASE_URL = "http://0.0.0.0:11434";
        WEBUI_AUTH = "False";
        ENABLE_RAG_WEB_SEARCH = "True";
        ENABLE_SEARCH_QUERY_GENERATION = "True";
        RAG_WEB_SEARCH_RESULT_COUNT = "3";
        RAG_WEB_SEARCH_CONCURRENT_REQUESTS = "10";
        RAG_WEB_SEARCH_ENGINE = "searxng";
        SEARXNG_QUERY_URL = "http://0.0.0.0:8888/search?q=<query>";
      };
    };

    # Btrfs Services
    btrfs = {
      autoScrub = {
        enable = true;
        interval = "weekly";
        fileSystems = [
          "/"
          "/home"
          "/nix"
          "/var"
        ];
      };
    };

    # Enable flatpak managment
    flatpak = {
      enable = true;
      update.onActivation = true;
      packages = [
        "com.stremio.Stremio"
      ];
    };

    # Openssh configuration
    openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };
  };
}
