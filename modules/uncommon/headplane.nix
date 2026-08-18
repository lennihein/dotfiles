{ config, pkgs, ... }:
{
  services.headplane = {
    enable = true;
    settings = {
      server = {
        host = "127.0.0.1";
        port = 3005;
        base_url = "https://headplane.bes.lennihein.com";
        cookie_domain = "bes.lennihein.com";
        cookie_secret_path = "/var/lib/headplane/cookie-secret";
        cookie_secure = true;
      };
      headscale = {
        url = "http://127.0.0.1:3001";
        public_url = "https://vpn.bes.lostinthe.cloud";
      };
    };
  };

  systemd.services.headplane = {
    preStart = ''
      if [ ! -f /var/lib/headplane/cookie-secret ]; then
        mkdir -p /var/lib/headplane
        tr -dc A-Za-z0-9 </dev/urandom | head -c 32 > /var/lib/headplane/cookie-secret
        chmod 600 /var/lib/headplane/cookie-secret
      fi
    '';
    after = [ "network-online.target" "headscale.service" ];
    wants = [ "headscale.service" ];
  };
}
