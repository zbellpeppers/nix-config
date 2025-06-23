{ ... }:
{
  age.secrets = {

    cf-dns-ddclient = {
      file = ../../secrets/cloudflare-dns-token.age;
      owner = "root";
      group = "root";
      mode = "0400";
    };

    cloudflare-env-api-caddy = {
      file = ../../secrets/cloudflare-env-api-caddy.age;
      owner = "root";
      group = "root";
      mode = "0400";
    };
  };
}
