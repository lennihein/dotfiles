{ config, pkgs, ... }:
{
  # Dual boot with Windows
  time.hardwareClockInLocalTime = true;
  boot.supportedFilesystems = [ "ntfs" ];
}
