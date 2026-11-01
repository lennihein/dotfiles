{ lib, ... }:
{
  networking.hostName = "seth";

  # Boot and ZRAM swap settings
  boot.tmp.cleanOnBoot = true;
  boot.loader.grub.configurationLimit = 3;
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  # Host-specific firewall settings
  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    allowedTCPPorts = [
      7681
      2333
      25565
    ];
    allowedUDPPorts = [
      19132
    ];
  };
  networking.nftables.enable = true;

  # Ensure secrets directory exists with restricted permissions
  systemd.tmpfiles.rules = [
    "d /var/lib/secrets 0700 root root -"
  ];

  # Rathole reverse proxy server
  services.rathole = {
    enable = true;
    role = "server";
    credentialsFile = "/var/lib/secrets/rathole.toml";
    settings = {
      server = {
        bind_addr = "0.0.0.0:2333";
        services = {
          minecraft = {
            bind_addr = "0.0.0.0:25565";
            type = "tcp";
          };
          minecraft-bedrock = {
            bind_addr = "0.0.0.0:19132";
            type = "udp";
          };
        };
      };
    };
  };

  system.stateVersion = lib.mkForce "23.11";
}
