{ lib, ... }:
{
  networking.hostName = "sobek";

  # Boot and ZRAM swap settings
  boot.tmp.cleanOnBoot = true;
  boot.loader.grub.configurationLimit = 1;
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  # Host-specific firewall settings
  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    allowedTCPPorts = [ 80 443 7681 ];
  };
  networking.nftables.enable = true;

  # Caddy reverse proxy for Punch!
  services.caddy = {
    enable = true;
    extraConfig = ''
      punch.sobek.lennihein.com {
          @api_bypass {
              path /api/watch/* /api/agent/* /api/health
          }
          handle @api_bypass {
              reverse_proxy 127.0.0.1:8000
          }
          handle {
              forward_auth 100.64.0.2:9091 {
                  uri /api/authz/forward-auth?authelia_url=https://auth.bes.lennihein.com
                  copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
              }
              reverse_proxy 127.0.0.1:8000
          }
      }
    '';
  };

  system.stateVersion = lib.mkForce "23.11";
}
