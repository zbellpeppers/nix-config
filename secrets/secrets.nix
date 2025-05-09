let
  zachary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFGth/M3cDvx9F4+Pb65uORRFYjaERZ4eajwPCtj8DOR";
  users = [zachary];

  king = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICyd7w56YoZaNJnrgrRWeU8Netw257ShiyrjE8bz4McF";
  systems = [king];
in {
  "cf-ddclient-token.age".publicKeys = [zachary];
  # "secret2.age".publicKeys = users ++ systems;
}
