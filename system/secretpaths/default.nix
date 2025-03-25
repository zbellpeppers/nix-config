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
  };
}
