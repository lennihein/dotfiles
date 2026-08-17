{ pkgs, lib, ... }:
{
  networking.hostName = "wsl";

  wsl.enable = true;
  wsl.defaultUser = "lenni";

  # Disable NetworkManager since WSL manages network interfaces directly
  networking.networkmanager.enable = lib.mkForce false;

  # Force state version to match the WSL installation default
  system.stateVersion = lib.mkForce "25.11";
}
