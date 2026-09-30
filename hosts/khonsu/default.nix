{ config, lib, pkgs, ... }:
{
  networking.hostName = "khonsu";

  # Boot loader configuration (UEFI + systemd-boot)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  # Latest kernel packages
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # System state version
  system.stateVersion = lib.mkDefault "26.05";
}
