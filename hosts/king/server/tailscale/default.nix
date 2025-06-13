{ ... }:
{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    extraSetFlags = [
      "--advertise-exit-node"
    ];
    extraUpFlags = [
      "--login-server=https://headscale.bell-peppers.com"
      "--accept-routes"
    ];
  };
}
