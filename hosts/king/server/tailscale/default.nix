{ ... }:
{
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
