{ ... }:
{
  age.secrets = {
    cf-dns-ddclient = {
      file = ../../secrets/cloudflare-dns-token.age;
      owner = "root";
      group = "root";
      mode = "0400";
    };
    cloudflare-acme-credentials = {
      file = ../../secrets/cloudflare-env-api-acme.age;
    };
    # The contents of the above should be:
    # CLOUDFLARE_DNS_API_TOKEN="YOUR_CLOUDFLARE_API_TOKEN"
  };
}
