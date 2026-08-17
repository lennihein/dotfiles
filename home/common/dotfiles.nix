{ config, pkgs, ... }:
{
  home.file = {

    ".config/bat/config".text = ''
      --theme="Dracula"
      --style="numbers,changes,header"
    '';

    ".config/starship.toml".source = ../files/starship.toml;

    ".config/helix/config.toml".source = ../files/helix.toml;

    ".config/kitty/kitty.conf".source = ../files/kitty/kitty.conf;
    ".config/kitty/dracula.conf".source = ../files/kitty/dracula.conf;
  };
}
