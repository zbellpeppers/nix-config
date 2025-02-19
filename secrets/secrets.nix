let
  # Define users and their ~/.ssh public keys
  zachary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOKH6VZnlWJ6CNUm1A0nfjrP9kYYWNzyt7nHHVbdhyFu";
  sarah = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILI6jSq53F/3hEmSs+oq9L4TwOo1PrDMAgcA1uo1CCV/";
  users = [zachary sarah];

  # Define root and their /etc/ssh public keys
  king = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN9bEsjSaEw3Khl4EvDX4ybevs/moRqv5N+YpbRsSjN8";
  queen = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzxQgondgEYcLpcPdJLrTdNgZ2gznOHCAxMdaceTUT1";
  systems = [king queen];
in {
  # Define specific secret keys. These keys are then called wherever they're used. Ex:
  # age.secrets.syncthing-zach.file = ../../../secrets/syncthing-zach.age;
  # syncthing.settings.gui.password = config.age.secrets.syncthing-zach.path;
  "syncthing-zach.age".publicKeys = [zachary king];
  "syncthing-queen.age".publicKeys = [sarah queen];
}
