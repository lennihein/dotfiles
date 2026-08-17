{ config, pkgs, lib, ... }:
{
  system.nixos.tags = ["vbox"];

  # Disable KVM
  virtualisation.libvirtd.enable = lib.mkForce false;

  # Enable VirtualBox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  # Add user to vbox group
  users.groups.vbox.members = [ "lenni" ];
}
