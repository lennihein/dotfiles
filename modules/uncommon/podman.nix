{ config, pkgs, ... }:
{
  # Podman container virtualization
  virtualisation.podman.enable = true;
  users.users.lenni.extraGroups = [ "docker" ]; # For podman docker socket compatibility
}
