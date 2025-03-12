#TODO Update Sarah and Queen's user and system ssh keys
let
  zachary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBaRxUhfTxYDc9D4ebtKfbwh0Kt7J0vQA24wZUwHvOpz";
  sarah = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0gPiWyXr6KB5RjkAsfEqGZp5VozMF9gawDH+tjfiMg";
  users = [zachary sarah];

  king = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFV6gaDEzfSEaVjXFCh4epG6UkT+dbGrChxU5humq6s1";
  queen = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEqPNjO8VCHW2DCxOBJWcrBpet/hB++ohhQIYRDF+lAl";
  systems = [king queen];
in {
  "actualbudget-password.age".publicKeys = [zachary sarah];
  "actualbudget-apikey.age".publicKeys = [zachary sarah];
}
