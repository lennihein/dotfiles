{ config, pkgs, ... }:
{
  # Gitea self-hosted Git service
  services.gitea = {
    enable = true;
    settings.server = {
      DOMAIN = "git.lennihein.com";
      HTTP_PORT = 3002;
    };
    settings.service = {
      DISABLE_REGISTRATION = true;
    };
  };
}
