{ config, pkgs, ... }:
{
  # Ignore lid switch when on AC power (new option path)
  services.logind.settings = {
    Login = {
      HandleLidSwitchExternalPower = "ignore";
    };
  };
}
