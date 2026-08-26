{ config, lib, pkgs, ... }:
{
  networking.hostName = "ptah";

  # Boot loader configuration (UEFI + GRUB)
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;
  boot.loader.grub.configurationLimit = 5;

  # System state version
  system.stateVersion = lib.mkDefault "24.11";
}
