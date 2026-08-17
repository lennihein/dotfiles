{ config, pkgs, ... }:
{
  # Enable nix-ld to run unpatched dynamic binaries
  programs.nix-ld.enable = true;
}
