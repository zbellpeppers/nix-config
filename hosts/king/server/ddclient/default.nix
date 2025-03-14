{config, ...}: {
  services.ddclient = {
    enable = true;
    protocol = "cloudflare";
    server = "api.cloudflare.com/client/v4";
    username = "token"; # Your Cloudflare account email
    passwordFile = config.age.secrets.actualbudget-ddclient-apitoken.path; # File containing just your API token
    zone = "bell-peppers.com"; # Your root domain
    domains = [
      "actualbudget.bell-peppers.com"
    ]; # The subdomain to update
    ssl = true;
    interval = "10min"; # Check every 10 minutes
    usev4 = "webv4, webv4=https://cloudflare.com/cdn-cgi/trace, webv4-skip=ip="; # Use web service to detect IPv4
    usev6 = "webv6, webv6=https://cloudflare.com/cdn-cgi/trace, webv6-skip=ip="; # Use web service to detect IPv6
    verbose = true; # For debugging, can set to false later
    quiet = false; # For debugging, can set to true later
    extraConfig = ''
      ttl=1
    '';
  };
}
