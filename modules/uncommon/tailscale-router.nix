{ config, pkgs, ... }:
{
  imports = [ ./tailscale.nix ];

  # Enable subnet router and exit node routing features
  services.tailscale.useRoutingFeatures = "both";
}
