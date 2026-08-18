{ pkgs, pkgsMaster, ... }:
{
  home.packages = with pkgs; [
    # TUI
    helix gitui ranger gdu bottom fastfetch
    # CLI
    bat eza rm-improved duf xcp less pkgsMaster.antigravity-cli gh todoist comma
    # utility
    zip unzip
    # network
    curl wget
    # debug
    gef
  ];
}
