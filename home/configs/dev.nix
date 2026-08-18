{ config, pkgs, pkgsStable, ... }:
{
  home.packages = with pkgs; [
    ghidra-bin meld
  ];
}
