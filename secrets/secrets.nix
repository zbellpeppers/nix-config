let
  zachary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICudWne21gv+v7CUO928GSyOvCCEzNIPqsCnyc8cOTUY";
  users = [ zachary ];

  king = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIO8wnkX591eH5zr+SUR1q+1tLY23ophD7N4KAenVBiv";
  systems = [ king ];
in
{
  "cloudflare-dns-token.age".publicKeys = [ zachary ];
  "cloudflare-dns-environment.age".publicKeys = [ zachary ];
  "cloudflare-email.age".publicKeys = [ zachary ];
  # "secret2.age".publicKeys = users ++ systems;
}
