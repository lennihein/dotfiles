{ config, pkgs, ... }:
{
  home.username = "lenni";
  home.homeDirectory = "/home/lenni";

  home.sessionVariables = {
    EDITOR = "vim";
    PAGER = "bat";
    TERMINAL = "kitty";
    BROWSER = "google-chrome-stable";
  };
}
