{ ... }:
{
  # Allow specific ports on tailscale network
  networking.firewall.interfaces."tailscale0" = {
    allowedTCPPorts = [ 5006 ];
  };
  # Allow tailscale traffic
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    extraUpFlags = [
      "--accept-routes"
      "--advertise-exit-node"
    ];
  };
}
