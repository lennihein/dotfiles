{ config, pkgs, ... }:
{
	imports = [
	];

	home = {
		sessionVariables = {
			GIT_SSH_COMMAND = "ssh -F ${config.home.homeDirectory}/.ssh/config";
		};
		shellAliases = {
			ssh = "ssh -F ${config.home.homeDirectory}/.ssh/config";
			scp = "scp -F ${config.home.homeDirectory}/.ssh/config";
		};
	};
}
