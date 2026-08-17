{ config, pkgs, ... }:
{
  # Enable Tailscale daemon
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };

  # Enable Headscale control server
  services.headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 3001;
    user = "lenni";
    settings = {
      server_url = "https://vpn.bes.lostinthe.cloud";
      dns = {
        nameservers.global = [ "100.64.0.2" ];
        override_local_dns = true;
        magic_dns = false;
      };
    };
  };
}
