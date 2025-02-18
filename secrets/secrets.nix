let
  zachary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOKH6VZnlWJ6CNUm1A0nfjrP9kYYWNzyt7nHHVbdhyFu";
  sarah = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILI6jSq53F/3hEmSs+oq9L4TwOo1PrDMAgcA1uo1CCV/";
  users = [zachary sarah];

  king = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN9bEsjSaEw3Khl4EvDX4ybevs/moRqv5N+YpbRsSjN8";
  queen = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzxQgondgEYcLpcPdJLrTdNgZ2gznOHCAxMdaceTUT1";
  systems = [king queen];
in {
  "syncthing-zach.age".publicKeys = [zachary king];
  "syncthing-queen.age".publicKeys = [sarah queen];
}
