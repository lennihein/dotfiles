{ config, pkgs, lib, ... }:
{
  services.filebrowser = {
    enable = true;
    settings = {
      port = 3003;
      address = "127.0.0.1";
      database = "/var/lib/filebrowser/filebrowser.db";
      root = "/data";
    };
  };

  # Enforce strict systemd sandboxing
  systemd.services.filebrowser.serviceConfig = {
    # Run with shared group membership to access Linx upload directory
    SupplementaryGroups = [ "shared-data" ];

    ProtectSystem = "strict";
    ProtectHome = true;
    PrivateTmp = true;
    PrivateDevices = true;
    NoNewPrivileges = true;
    CapabilityBoundingSet = "";
    RestrictAddressFamilies = [ "AF_INET" "AF_INET6" ];
    
    ReadWritePaths = [
      "/var/lib/filebrowser"
      "/data"
    ];
  };

  # Override filebrowser tmpfiles rule to allow linx-server to traverse /data
  systemd.tmpfiles.settings.filebrowser."/data".d = {
    group = lib.mkForce "shared-data";
    mode = lib.mkForce "2770";
  };

  # Ensure /data/share exists with correct permissions
  systemd.tmpfiles.rules = [
    "d /data/share 2770 filebrowser shared-data - -"
  ];

  # Shared group for Filebrowser and Linx
  users.groups.shared-data = {};
}
