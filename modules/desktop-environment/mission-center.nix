{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mission-center
    nethogs
    lm_sensors
  ];

  # Grant capabilities to nethogs for per-process network stats in Mission Center
  security.wrappers.nethogs = {
    source = "${pkgs.nethogs}/bin/nethogs";
    capabilities = "cap_net_admin,cap_net_raw,cap_dac_read_search,cap_sys_ptrace+pe";
    owner = "root";
    group = "root";
  };

  # Allow non-root reading of CPU energy counters for power metrics
  services.udev.extraRules = ''
    SUBSYSTEM=="powercap", KERNEL=="intel-rapl*", RUN+="${pkgs.coreutils}/bin/chmod a+r /sys/%p/energy_uj"
  '';
}
