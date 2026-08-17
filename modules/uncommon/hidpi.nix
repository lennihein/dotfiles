{ config, pkgs, ... }:
{
  # HiDPI support
  environment.variables = {
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=1";
  };
}