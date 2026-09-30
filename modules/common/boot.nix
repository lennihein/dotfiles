{ lib, ... }:
{
  # Retain only the latest 5 configurations in bootloader menus to avoid filling up /boot
  boot.loader.grub.configurationLimit = lib.mkDefault 5;
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 5;
}
