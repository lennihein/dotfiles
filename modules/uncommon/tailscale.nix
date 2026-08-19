{ config, lib, pkgs, ... }:
{
  # Enable Tailscale daemon with client routing support
  services.tailscale = {
    enable = true;
    useRoutingFeatures = lib.mkDefault "client";
  };

  # Host firewall setting to trust Tailscale traffic
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
}
