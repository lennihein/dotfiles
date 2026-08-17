{ config, pkgs, ... }:
{
  # Install the package
  environment.systemPackages = [ pkgs.linx-server ];

  # Configure a custom systemd service with strict sandboxing
  systemd.services.linx-server = {
    description = "Linx media-sharing server";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig = {
      ExecStart = ''
        ${pkgs.linx-server}/bin/linx-server \
          -bind 127.0.0.1:3004 \
          -filespath /data/share \
          -metapath /var/lib/linx-server/meta
      '';
      
      Restart = "always";
      
      # Group membership for shared file access with Filebrowser
      SupplementaryGroups = [ "shared-data" ];

      # Systemd Sandboxing
      DynamicUser = true;
      StateDirectory = "linx-server";
      
      ProtectSystem = "strict";
      ProtectHome = true;
      PrivateTmp = true;
      PrivateDevices = true;
      NoNewPrivileges = true;
      CapabilityBoundingSet = "";
      RestrictAddressFamilies = [ "AF_INET" "AF_INET6" ];
      
      # Limit write paths to its own state directory and /data/share
      ReadWritePaths = [
        "/var/lib/linx-server"
        "/data/share"
      ];
    };
  };

  # Shared group for Filebrowser and Linx
  users.groups.shared-data = {};
}
