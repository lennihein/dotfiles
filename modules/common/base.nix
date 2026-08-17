{ config, pkgs, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
    # packageOverrides = pkgs: {
    #   master = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/heads/master.zip") {
    #     config = config.nixpkgs.config;
    #   };
    # };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
