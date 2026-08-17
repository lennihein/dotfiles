{ config, pkgs, ... }:
{
  # Enable firewall
  networking.firewall = {
    enable = true;
    # allowedTCPPorts = [ ... ];
    # allowedUDPPorts = [ ... ];
  };
}
