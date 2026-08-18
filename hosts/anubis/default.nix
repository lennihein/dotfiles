{ config, lib, pkgs, ... }:
{
  networking.hostName = "anubis";

  # Boot loader configuration (UEFI + systemd-boot)
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  # System state version
  system.stateVersion = lib.mkDefault "26.05";
}
