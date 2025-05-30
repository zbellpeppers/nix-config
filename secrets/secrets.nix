let
  zachary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOw2QxFbEcUOt+FEnfcmbDXdvAyivyhnhhGcbV4Bme5H";
  users = [zachary];

  king = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICT6xOvW/SFpdqByD1Tp1fLzwSANaFQFu5FkkOo664JL";
  systems = [king];
in {
  "cloudflare-dns-token.age".publicKeys = [zachary];
  "cloudflare-dns-environment.age".publicKeys = [zachary];
  "cloudflare-email.age".publicKeys = [zachary];
  # "secret2.age".publicKeys = users ++ systems;
}
