let
  zachary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBaRxUhfTxYDc9D4ebtKfbwh0Kt7J0vQA24wZUwHvOpz";
  sarah = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILI6jSq53F/3hEmSs+oq9L4TwOo1PrDMAgcA1uo1CCV/";
  users = [zachary sarah];

  king = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFV6gaDEzfSEaVjXFCh4epG6UkT+dbGrChxU5humq6s1";
  queen = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzxQgondgEYcLpcPdJLrTdNgZ2gznOHCAxMdaceTUT1";
  systems = [king queen];
in {
  "actualbudget-password.age".publicKeys = [zachary sarah];
  "actualbudget-apikey.age".publicKeys = [zachary sarah];
}
