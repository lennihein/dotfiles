{ config, pkgs, ... }:
{
  # Gitea self-hosted Git service
  services.gitea = {
    enable = true;
    settings.server = {
      ROOT_URL = "https://git.lennihein.com/";
      HTTP_PORT = 3002;
    };
    settings.service = {
      DISABLE_REGISTRATION = true;
    };
  };
}
