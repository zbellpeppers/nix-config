let
  zachary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMvPv3DN4abISLxbszLrHK5rYMkWx5oNBexLvRzkTAPV";
  # king = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIO8wnkX591eH5zr+SUR1q+1tLY23ophD7N4KAenVBiv";
in
{
  "cloudflare-dns-token.age".publicKeys = [ zachary ];
  "cloudflare-env-api-caddy.age".publicKeys = [ zachary ];
  # "secret2.age".publicKeys = users ++ systems;
}
