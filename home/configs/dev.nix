{ config, pkgs, pkgsStable, pwndbg, ... }:
{
  home.packages = with pkgs; [
    ghidra-bin meld
    pwndbg
  ];
}
