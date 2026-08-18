{ lib, ... }:
{
  networking.hostName = "seth";

  # Boot and ZRAM swap settings
  boot.tmp.cleanOnBoot = true;
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  # Host-specific firewall settings
  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    allowedTCPPorts = [ 80 443 ];
  };
  networking.nftables.enable = true;

  system.stateVersion = lib.mkForce "23.11";
}
