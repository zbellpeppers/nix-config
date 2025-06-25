{ ... }:
{
  services.headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 8080;

    settings = {
      server_url = "https://headscale.bell-peppers.com";
      listen_addr = "0.0.0.0:8080";
      metrics_listen_addr = "127.0.0.1:9090";

      # Private key settings
      noise.private_key_path = "/var/lib/headscale/noise_private.key";
      # Database
      database = {
        type = "sqlite3";
        sqlite = {
          path = "/var/lib/headscale/db.sqlite";
        };
      };

      # DNS configuration
      dns = {
        override_local_dns = false;
        base_domain = "bpf.lan";
        magic_dns = true;
        nameservers.global = [
          "1.1.1.1"
          "8.8.8.8"
        ];
        extra_records = [
          {
            name = "actualbudget.bpf.lan"; # full FQDN
            type = "A"; # only A / AAAA are supported
            value = "100.64.0.1"; # king’s Tailscale IPv4
          }
          {
            name = "actualbudget.bpf.lan"; # full FQDN
            type = "AAAA"; # only A / AAAA are supported
            value = "fd7a:115c:a1e0::1"; # king’s Tailscale IPv6
          }
          {
            name = "minecraft.bpf.lan"; # full FQDN
            type = "A"; # only A / AAAA are supported
            value = "100.64.0.1"; # king’s Tailscale IPv4
          }
          {
            name = "samba.bpf.lan"; # the alias you want to use
            type = "A"; # only A/AAAA are supported
            value = "100.64.0.1";
          }
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
