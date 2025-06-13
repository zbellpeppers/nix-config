{ ... }:
{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    extraUpFlags = [
      "--accept-routes"
      "--advertise-exit-node"
    ];
  };
}
