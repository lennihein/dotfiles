{ pkgs, pkgsMaster, ... }:
{
  home.packages = with pkgs; [
    google-chrome
    kitty
    obsidian
    pkgsMaster.antigravity-ide
  ];
}
