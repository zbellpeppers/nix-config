{ ... }:
{
  imports = [
    #./caddy
    ./ddclient
    ./headscale
    ./nginx
    ./podman
    ./samba
    ./tailscale
  ];
}
