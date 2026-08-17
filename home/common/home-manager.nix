{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;

  # Disable Home Manager manual outputs to speed builds and avoid options.json warning
  manual = {
    html.enable = false;
    manpages.enable = false;
  };
}
