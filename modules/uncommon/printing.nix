{ config, pkgs, ... }:
{
  # Enable CUPS printing service
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      epson-escpr
      epson-escpr2
      gutenprint
    ];
  };

  # Enable Avahi daemon for local network printer auto-discovery (mDNS)
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Grant user permission to administer print jobs/printers
  users.users.lenni.extraGroups = [ "lp" "lpadmin" ];
}
