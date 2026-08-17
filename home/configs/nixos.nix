{ config, pkgs, ... }:
{
  programs.fish = {
    functions = {
      nixos-generations = "pls nix-env -p /nix/var/nix/profiles/system --list-generations $argv";
      nixos-history = "nix profile diff-closures --profile /nix/var/nix/profiles/system $argv";
    };
  };
}
