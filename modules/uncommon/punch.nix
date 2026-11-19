{ ... }:
{
  services.punch = {
    enable = true;
    host = "0.0.0.0";
    port = 8000;
    databasePath = "/var/lib/punch/punch.db";
    timezone = "Europe/Berlin";
    trustProxyHeaders = true;
    seedReportPaths = "/var/lib/punch/seed/september_26.txt";
  };
}
