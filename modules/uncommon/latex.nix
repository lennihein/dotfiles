{ config, pkgs, ... }:
{
  system.nixos.tags = ["latex"];

  # Define user packages for LaTeX
  users.users.lenni = {
    packages = with pkgs; [
      # tex
      texlive.combined.scheme-full
      texstudio
      inkscape-with-extensions  # for svgs
      pandoc
      tectonic
    ];
  };
}
