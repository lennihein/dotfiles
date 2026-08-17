{ config, pkgs, ... }:
{
  services.udev.extraRules = ''
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE="660", GROUP="plugdev"
  '';
  users.groups.plugdev.members = [ "lenni" ];
  users.groups.dialout.members = [ "lenni" ];
  users.users.lenni.packages = with pkgs; [
    cutecom usbutils gcc-arm-embedded openocd
  ];
}
