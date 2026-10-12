{ config, pkgs, pkgsMaster, ... }:
{
  home.packages = with pkgs; [
    ghidra-bin meld
    # CLI tools
    gh
    todoist
    pkgsMaster.antigravity-cli
  ];
}
