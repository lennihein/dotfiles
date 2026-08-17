{ config, pkgs, ... }:
{
  security.doas.enable = true;
  security.doas.extraRules = [{
    users = [ "lenni" ];
    keepEnv = true;
    noPass = true;
  }];
}