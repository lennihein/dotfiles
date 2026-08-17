{ config, pkgs, ... }:
{
  # Dedupe the Nix store
  nix.settings.auto-optimise-store = true;

  # Garbage collection
  nix.gc.automatic = true;
  nix.gc.dates = "*-*-* 4:00:00";
  # Without options it will only clean the store, not delete old generations
  nix.gc.options = "";

  # Automatically delete all but the last 5 system generations before the GC runs
  systemd.services.nix-gc.preStart = ''
    ${pkgs.nix}/bin/nix-env --profile /nix/var/nix/profiles/system --delete-generations +5
  '';
}
