{ config, pkgs, lib, ... }:
{

	imports = [

	];
  
	home.file.".config/neofetch/config.conf".source = lib.mkForce ( pkgs.writeText "neofetch_archwsl.conf" ''
	${builtins.readFile ../files/neofetch_wsl.conf}

	ascii_distro="arch_small"

	'' ) ;
}
