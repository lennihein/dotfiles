{ config, pkgs, ... }:
{
  # Flat mouse profile
  services.libinput = {
    enable = true;
    mouse.accelProfile = "flat";
  };
}
