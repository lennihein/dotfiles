{ config, pkgs, ... }:
{
  # Automatic upgrades
  system.autoUpgrade.enable = true;
  # for unmanaged server enable this:
  system.autoUpgrade.allowReboot = false;
  # every day at 4am
  system.autoUpgrade.dates = "*-*-* 4:00:00";
}
