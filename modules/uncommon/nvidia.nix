{ config, pkgs, ... }:
{
  # Enable NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # NVIDIA settings
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production; # or stable;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.forceFullCompositionPipeline = true;
  hardware.nvidia.nvidiaSettings = true;
}
