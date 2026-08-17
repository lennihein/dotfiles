{ config, pkgs, ... }:
{
  home.file = {
    # WSL specific configuration (legacy X server and hardcoded paths)
    ".config/fish/conf.d/wsl.fish" = {
      source = ../files/wsl.fish;
    };
  };
}
