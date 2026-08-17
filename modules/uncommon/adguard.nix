{ config, pkgs, ... }:
{
  services.adguardhome.enable = true;
  networking.nameservers = [ "127.0.0.1" ];
}
