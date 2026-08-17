# Repository Guidelines

## Project Structure & Module Organization
- `flake.nix`: Flake entry defining NixOS hosts (`nixosConfigurations`) and standalone Home Manager profiles (`homeConfigurations`).
- `hosts/`: Host-specific hardware and system configurations (e.g., `dell`, `ptah`, `bes`, `wsl`).
- `modules/`: System-level NixOS modules (desktop environments, hardware tweaks, services).
- `home/`: User-level Home Manager configurations.
  - `home/common/`: Shared user modules (shell, vim, git, packages, dotfiles).
  - `home/configs/`: OS/role profiles (desktop, dev, debian, wsl, arch, guest).
  - `home/files/`: Static config assets (kitty, starship, helix, fish scripts).

## Build, Test, and Development Commands
- Evaluate flake: `nix flake check`
- Apply NixOS locally: `sudo nixos-rebuild switch --flake .#<hostname> --no-write-lock-file`
- Apply Home Manager locally: `home-manager switch --flake .#<profile> --refresh --no-write-lock-file`
- Remote NixOS apply: `sudo nixos-rebuild switch --flake github:lennihein/dotfiles#<hostname> --no-write-lock-file`
- Remote Home Manager apply: `home-manager switch --flake github:lennihein/dotfiles#<profile> --refresh --no-write-lock-file`

## Coding Style & Naming Conventions
- Nix style: small, focused modules returning attribute sets; one option per line.
- Indentation: 2 spaces preferred.
- Inputs: main channel on `nixos-unstable`; stable channel exposed as `pkgsStable` (`nixos-25.05`), master channel as `pkgsMaster`.
- Unfree packages: enabled with `config.allowUnfree = true`.
- Flake lock: this repo ignores `flake.lock` by default; use `--no-write-lock-file` where appropriate.
