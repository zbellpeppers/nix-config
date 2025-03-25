let
  zachary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE7x6V7LeZK9N5vxBKUG1sB96EWTz4jqu9nR0WnzaBFx";
  sarah = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICJtMs0C0iUNAoWGt3BDQk4iv7mFu8HWCqCMKFKT4n9A";
  users = [zachary sarah];

  king = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIATX6qsFw0xedh64vcngiIleBmVQ4lnvyntqmkyrKK2k";
  queen = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEqPNjO8VCHW2DCxOBJWcrBpet/hB++ohhQIYRDF+lAl";
  systems = [king queen];
in {
  "cloudflare-dns-apitoken.age".publicKeys = [zachary sarah];
}
