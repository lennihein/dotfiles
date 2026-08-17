{ config, pkgs, ... }:
{
  # Disable manual
  documentation.nixos.enable = false;

  # Disable xterm
  services.xserver.excludePackages = [ pkgs.xterm ];
}