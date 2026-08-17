{ config, pkgs, lib, ... }:
{
  # Optionally disable GNOME keyring
  # services.gnome.gnome-keyring.enable = lib.mkForce false;

  # GNOME excludes
  environment.gnome.excludePackages = with pkgs; [
    baobab      # disk usage analyzer
    cheese      # photo booth
    eog         # image viewer
    epiphany    # web browser
    simple-scan # document scanner
    totem       # video player
    yelp        # help viewer
    evince      # document viewer
    file-roller # archive manager
    geary       # email client
    seahorse    # password manager
    pkgs.snapshot    # camera
    gnome-calculator gnome-calendar gnome-characters gnome-contacts
    gnome-font-viewer gnome-logs gnome-maps gnome-music
    gnome-disk-utility gnome-system-monitor pkgs.gnome-connections
    pkgs.gnome-tour pkgs.gnome-photos pkgs.gnome-console
  ];

  # GNOME extensions
  environment.systemPackages = with pkgs; [
    pkgs.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.no-a11y
    gnomeExtensions.trimmer
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-panel
  ];
}
