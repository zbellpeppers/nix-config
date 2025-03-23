let
  zachary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3RPvYWObocEcgF43iTQJu5ANAmyHfhYElRWBYCVAJM";
  sarah = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICJtMs0C0iUNAoWGt3BDQk4iv7mFu8HWCqCMKFKT4n9A";
  users = [zachary sarah];

  king = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFxEVmsQlJ6DV32h6ol0jXjc9aRL0PPPvx5CNhhuy66O";
  queen = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEqPNjO8VCHW2DCxOBJWcrBpet/hB++ohhQIYRDF+lAl";
  systems = [king queen];
in {
  "cloudflare-dns-apitoken.age".publicKeys = [zachary sarah];
}
