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

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "@wheel" "lenni" ];
    warn-dirty = false;
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://lennihein.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "lennihein.cachix.org-1:NfNMNT0Z/t/Ykp8BKtuUAsY2PbO8GmfxJZTApFRusWo="
    ];
  };

}
