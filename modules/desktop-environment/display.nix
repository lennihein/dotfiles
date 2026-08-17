{ config, pkgs, ... }:
{
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment
  # services.displayManager.defaultSession = "gnome";
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  # GNOME settings daemon
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];
}
