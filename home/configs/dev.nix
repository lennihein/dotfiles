{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    ghidra-bin meld
  ];
}
