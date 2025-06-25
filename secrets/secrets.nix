let
  zachary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHYfHn+0/m4z47XuHBP8kER0ZNJwlLH/1WV+jPDzYu2S";
  # king = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIO8wnkX591eH5zr+SUR1q+1tLY23ophD7N4KAenVBiv";
in
{
  "cloudflare-dns-token.age".publicKeys = [ zachary ];
  "cloudflare-dns-environment.age".publicKeys = [ zachary ];
  "cloudflare-email.age".publicKeys = [ zachary ];
  "cloudflare-env-api-caddy.age".publicKeys = [ zachary ];
  # "secret2.age".publicKeys = users ++ systems;
}
