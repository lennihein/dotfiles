{ config, pkgs, ... }:
{

	imports = [

	];

	home.file = {
		".config/fish/conf.d/arch.fish".source = ../files/arch.fish;
	};
}
