# dotfiles

Unified NixOS and Home Manager configuration monorepo.

## Structure

- **`hosts/`**: NixOS system host definitions (`dell`, `ptah`, `bes`, `wsl`).
- **`modules/`**: NixOS system-level modules (DEs, services, drivers).
- **`home/`**: Home Manager configurations and user dotfiles.
  - **`home/common/`**: Shared configuration across all systems (shell, git, vim, fastfetch, starship).
  - **`home/configs/`**: Target-specific profiles (desktop, dev, debian, wsl, arch, guest).
  - **`home/files/`**: Static configuration assets.

## Usage

### 1. NixOS Systems

To apply on a NixOS host (e.g. `dell`, `ptah`, `bes`, `wsl`):

```bash
# Local
sudo nixos-rebuild switch --flake .#<hostname> --no-write-lock-file

# Remote
sudo nixos-rebuild switch --flake github:lennihein/dotfiles#<hostname> --no-write-lock-file
```

### 2. Standalone Home Manager (Debian, Arch, Non-NixOS)

To apply standalone Home Manager (e.g. `debianwsl`, `archwsl`, `debian-headless`, `nixos`):

```bash
# Local
home-manager switch --flake .#<profile> --refresh --no-write-lock-file

# Remote
home-manager switch --flake github:lennihein/dotfiles#<profile> --refresh --no-write-lock-file
```
