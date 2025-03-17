let
  zachary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3RPvYWObocEcgF43iTQJu5ANAmyHfhYElRWBYCVAJM";
  sarah = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICJtMs0C0iUNAoWGt3BDQk4iv7mFu8HWCqCMKFKT4n9A";
  users = [zachary sarah];

  king = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHcVjJwbAGu5Hxp6wnIjdCv94PK5mg/tN2hFRIFMCxkA";
  queen = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEqPNjO8VCHW2DCxOBJWcrBpet/hB++ohhQIYRDF+lAl";
  systems = [king queen];
in {
  "actualbudget-password.age".publicKeys = [zachary sarah];
  "nginx-apitoken.age".publicKeys = [zachary sarah];
  "cloudflare-dns-apitoken.age".publicKeys = [zachary sarah];
  "acme-cloudflare-apitoken.age".publicKeys = [zachary sarah];
}
