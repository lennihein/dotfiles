# Repository Guidelines

## Project Structure & Module Organization
- `flake.nix`: Flake entry defining NixOS hosts (`nixosConfigurations`) and standalone Home Manager profiles (`homeConfigurations`).
- `hosts/`: Host-specific hardware and system configurations (e.g., `dell`, `ptah`, `anubis`, `bes`, `seth`, `sobek`, `wsl`).
- `modules/`: System-level NixOS modules (desktop environments, hardware tweaks, services).
- `home/`: User-level Home Manager configurations.
  - `home/common/`: Shared user modules (shell, vim, git, packages, dotfiles).
  - `home/configs/`: OS/role profiles (desktop, dev, debian, wsl, arch, guest).
  - `home/files/`: Static config assets (kitty, starship, helix, fish scripts).

## Build, Test, and Development Commands
- Evaluate flake: `nix flake check`
- Apply NixOS locally: `doas nixos-rebuild switch --flake .#<hostname>`
- Apply Home Manager locally: `home-manager switch --flake .#<profile>`
- Remote NixOS apply: `doas nixos-rebuild switch --flake github:lennihein/dotfiles#<hostname>`
- Remote Home Manager apply: `home-manager switch --flake github:lennihein/dotfiles#<profile>`
- Remote deploy-rs apply (single node): `nix run github:serokell/deploy-rs -- .#<hostname>`
- Remote deploy-rs apply (all nodes): `nix run github:serokell/deploy-rs -- .`
- Update flake inputs: `nix flake update`


## Coding Style & Naming Conventions
- Nix style: small, focused modules returning attribute sets; one option per line.
- Indentation: 2 spaces preferred.
- Inputs: main channel on `nixos-unstable`; master channel as `pkgsMaster`.
- Unfree packages: enabled with `config.allowUnfree = true`.
- Flake lock: `flake.lock` is tracked in git; update explicitly via `nix flake update` or weekly CI schedule.

