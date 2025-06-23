let
  zachary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILZsmJla2Ynp6T2nUwNwgb6ijvBqoiaBn5OsBcpFEixf";
  # king = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIO8wnkX591eH5zr+SUR1q+1tLY23ophD7N4KAenVBiv";
in
{
  "cloudflare-dns-token.age".publicKeys = [ zachary ];
  "cloudflare-dns-environment.age".publicKeys = [ zachary ];
  "cloudflare-email.age".publicKeys = [ zachary ];
  "cloudflare-env-api-caddy.age".publicKeys = [ zachary ];
  # "secret2.age".publicKeys = users ++ systems;
}
