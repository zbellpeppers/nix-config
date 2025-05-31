{...}: {
  age.secrets = {
    cf-dns-nginx = {
      file = ../../secrets/cloudflare-dns-environment.age;
      owner = "acme";
      group = "acme";
      mode = "0400";
    };

    cf-email-nginx = {
      file = ../../secrets/cloudflare-email.age;
      owner = "acme";
      group = "acme";
      mode = "0400";
    };

    cf-dns-ddclient = {
      file = ../../secrets/cloudflare-dns-token.age;
      owner = "root";
      group = "root";
      mode = "0400";
    };

    latitude = {
      file = ../../secrets/location-latitude.age;
      owner = "root";
      group = "root";
      mode = "0400";
    };

    longitude = {
      file = ../../secrets/location-longitude.age;
      owner = "root";
      group = "root";
      mode = "0400";
    };
  };
}
