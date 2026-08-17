{ config, pkgs, ... }:
{
  home.sessionVariables = {
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    GDK_SCALE = "2";
    QT_SCALE_FACTOR = "2";
  };
}
