{ config, pkgs, ... }:
{
  imports = [ ./tailscale.nix ];

  # Enable subnet router and exit node routing features
  services.tailscale.useRoutingFeatures = "both";

  # Ethtool utility for network hardware configuration
  environment.systemPackages = [ pkgs.ethtool ];

  # UDP GRO forwarding optimization for Tailscale routing / exit nodes
  # See: https://tailscale.com/s/ethtool-config-udp-gro
  networking.networkmanager.dispatcherScripts = [
    {
      source = pkgs.writeShellScript "tailscale-udp-gro" ''
        if [ "$2" = "up" ]; then
          ${pkgs.ethtool}/bin/ethtool -K "$1" rx-udp-gro-forwarding on rx-gro-list off 2>/dev/null || true
        fi
      '';
      type = "basic";
    }
  ];

  systemd.services.tailscale-udp-gro-forwarding = {
    description = "Enable UDP GRO forwarding on default network interface for Tailscale";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "tailscale-udp-gro" ''
        NETDEV=$(${pkgs.iproute2}/bin/ip -o route get 8.8.8.8 2>/dev/null | ${pkgs.gawk}/bin/awk '{print $5}')
        if [ -n "$NETDEV" ]; then
          ${pkgs.ethtool}/bin/ethtool -K "$NETDEV" rx-udp-gro-forwarding on rx-gro-list off 2>/dev/null || true
        fi
      '';
    };
  };
}
