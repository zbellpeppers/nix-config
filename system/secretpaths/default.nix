{...}: {
  age.secrets = {
    cloudflare-dns-apitoken = {
      file = ../../secrets/cloudflare-dns-apitoken.age;
    };
  };
}
