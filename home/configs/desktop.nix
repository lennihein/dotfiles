{ pkgs, pkgsStable, pkgsMaster, ... }:
{
  home.packages = with pkgs; [
    google-chrome
    kitty
    vscode
    obsidian
    pkgsStable.termius
    pkgsMaster.antigravity-ide
  ];
}
