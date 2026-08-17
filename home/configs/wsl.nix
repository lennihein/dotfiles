{ config, pkgs, ... }:
{

	imports = [
		./hidpi.nix
	];

	home.file = {
		".config/fastfetch/config.jsonc".source = ../files/fastfetch.jsonc;
	};
}
