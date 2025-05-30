let
  zachary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOw2QxFbEcUOt+FEnfcmbDXdvAyivyhnhhGcbV4Bme5H";
  users = [zachary];

  king = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICT6xOvW/SFpdqByD1Tp1fLzwSANaFQFu5FkkOo664JL";
  systems = [king];
in {
  "cf-ddclient-token.age".publicKeys = [zachary];
  # "secret2.age".publicKeys = users ++ systems;
}
