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
      containers = {
        actual-budget = {
          image = "actualbudget/actual-server";
          autoStart = true;
          ports = ["0.0.0.0:5006:5006"];
        };
      };
    };
  };
}
