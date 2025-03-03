{...}: {
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
      storageDriver = "btrfs";
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    oci-containers = {
      backend = "docker";
      # Uncommenting below will allow named container to be run as a systemd service
      # containers = {
      #   container-name = {
      #     image = "container-image";
      #     autoStart = true;
      #     ports = ["127.0.0.1:1234:1234"];
      #   };
      # };
    };
  };
}
