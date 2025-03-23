{...}: {
  # Examples to use elsewhere in config:
  # To path to the file itself use:
  # config.age.secrets.cloudflare-dns-apitoken.path
  # To retrieve the specific contents of the file use:
  # config.age.secrets.cloudflare-dns-apitoken.content
  age.secrets = {
    cloudflare-dns-apitoken = {
      file = ../../secrets/cloudflare-dns-apitoken.age;
    };
    elevation-in-meters = {
      file = ../../secrets/elevation-in-meters.age;
    };
    latitude = {
      file = ../../secrets/latitude.age;
    };
    longitude = {
      file = ../../secrets/longitude.age;
    };
  };
}
