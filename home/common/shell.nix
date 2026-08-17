{ config, pkgs, ... }:
{
		programs.fish = {
		enable = true;

		interactiveShellInit = ''
      set fish_greeting
    '';

		functions = {
			pls = "doas (which $argv[1]) $argv[2..-1]";
			squash = "git reset (git commit-tree 'HEAD^{tree}' -m $argv)";
			crun =''gcc $argv -o run_tmp && ./run_tmp; set ret_code $status || echo && rm run_tmp && echo "exit code: "$ret_code'';
			gitignore = ''echo "$argv" >> .gitignore'';
			gtree = "git log --all --decorate --graph --abbrev-commit --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)';";
			detached = "$argv .&> /dev/null & && disown";
			run = "nix run nixpkgs#$argv[1] $argv[2..-1]";
		};

		shellAbbrs = {
			l = "eza -la";
			ll = "eza -l";
			ls = "eza";
			lsla = "eza -la";
			tree = "eza -T";
			# rm = "rip";
			# rm_ = "rm";
			py = "python3";
			gitclean = "git clean -d -i -x";
			cp = "xcp";
		};
	};

	programs.starship = {
		enable = true;
	};
}
