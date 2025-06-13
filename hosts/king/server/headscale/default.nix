{ ... }:
{
  services.headscale = {
    enable = true;
    address = "127.0.0.1";
    port = 8080;

    settings = {
      server_url = "https://headscale.bell-peppers.com";
      listen_addr = "127.0.0.1:8080";
      metrics_listen_addr = "127.0.0.1:9090";

      # Database
      database = {
        type = "sqlite3";
        sqlite = {
          path = "/var/lib/headscale/db.sqlite";
        };
      };

      # DNS configuration
      dns = {
        override_local_dns = true;
        base_domain = "bpf.lan";
        magic_dns = true;
        nameservers.global = [
          "1.1.1.1"
          "8.8.8.8"
        ];
      };

      # DERP configuration for NAT traversal
      derp = {
        server = {
          enable = false;
        };
        urls = [
          "https://controlplane.tailscale.com/derpmap/default"
        ];
        auto_update_enabled = true;
        update_frequency = "24h";
      };

      # Disable Tailscale's login server
      disable_check_updates = true;
      ephemeral_node_inactivity_timeout = "30m";
      node_update_check_interval = "10s";
    };
  };

  # Ensure headscale data directory exists
  systemd.tmpfiles.rules = [
    "d /var/lib/headscale 0755 headscale headscale -"
  ];
}
