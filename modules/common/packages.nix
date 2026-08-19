{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        # essentials
        wget
        lsof dig file
        atool zip unzip
        python3
        
        # command line tools 
        htop bottom gdu fastfetch ranger tldr gitui bat fzf ripgrep rm-improved eza nvd procs fd duf nixfmt
    ];
    programs.fish.enable = true;
    programs.vim = {
      defaultEditor = true;
      enable = true;
    };
    programs.git = {
      enable = true;
      config = {
        safe.directory = [
          "/home/lenni/dotfiles"
          "/home/lenni/dotfiles/.git"
          "/etc/nixos"
        ];
      };
    };
    programs.dconf.enable = true;

    # Register fish as a shell
    environment.shells = with pkgs; [ fish ];
}
