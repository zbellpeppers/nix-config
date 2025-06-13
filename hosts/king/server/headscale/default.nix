{ ... }:
{
  services.headscale = {
    enable = true;
    settings = {
      server_url = "https://headscale.bell-peppers.com:443";
      dns.base_domain = "bpf.lan";
    };
  };
}
