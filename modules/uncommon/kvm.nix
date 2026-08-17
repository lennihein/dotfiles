{ config, pkgs, ... }:
{
  # KVM and libvirt virtualization
  virtualisation.libvirtd.enable = true;
  environment.systemPackages = with pkgs; [
    virtiofsd
    virt-manager
  ];
  users.users.lenni.extraGroups = [ "libvirt" ];
}
