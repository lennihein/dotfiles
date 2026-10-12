{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # TUI
    helix gitui ranger gdu bottom fastfetch
    # CLI
    bat eza rm-improved duf xcp less
    # utility
    zip unzip
    # network
    curl wget
    # debug
    gef
  ];
}
