{config, ...}: {
  services.ddclient = {
    enable = true;
    protocol = "cloudflare";
    username = "token"; # token if using apitoken or Cloudflare email
    passwordFile = config.age.secrets.cf-dns-token.path;
    zone = "bell-peppers.com"; # Your root domain
    domains = [
      "actualbudget.bell-peppers.com"
    ]; # The subdomain to update
    ssl = true;
    interval = "5min"; # Check every 10 minutes
    usev4 = "webv4, webv4=https://cloudflare.com/cdn-cgi/trace, webv4-skip=ip=";
    usev6 = "";
    verbose = true; # For debugging, can set to false later
    extraConfig = ''
      ttl=1
    '';
  };
}
