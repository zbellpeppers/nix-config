let
  zachary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPtgFGVHRlQALR48HSerZdZHp3542qhYqSAjHwWA/5Ku";
  # king = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIO8wnkX591eH5zr+SUR1q+1tLY23ophD7N4KAenVBiv";
in
{
  "cloudflare-dns-token.age".publicKeys = [ zachary ];
  "traccar-env.age".publicKeys = [ zachary ];
  "postgres-traccar-db-pw.age".publicKeys = [ zachary ];
  # "secret2.age".publicKeys = users ++ systems;
}
