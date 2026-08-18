{ config, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.termius ];
}
