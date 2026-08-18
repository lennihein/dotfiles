# dotfiles

Unified NixOS and Home Manager configuration monorepo.

## Structure

- [**`hosts/`**](hosts/): NixOS system host definitions (`dell`, `ptah`, `bes`, `wsl`).
- [**`modules/`**](modules/): NixOS system-level modules (DEs, services, drivers).
- [**`home/`**](home/): Home Manager configurations and user dotfiles.
  - [**`home/common/`**](home/common/): Shared configuration across all systems (shell, git, vim, fastfetch, starship).
  - [**`home/configs/`**](home/configs/): Target-specific profiles (desktop, dev, debian, wsl, arch, guest).
  - [**`home/files/`**](home/files/): Static configuration assets.

## Usage

### 1. NixOS Systems

To apply on a NixOS host (e.g. `dell`, `ptah`, `bes`, `wsl`):

```bash
# Local
sudo nixos-rebuild switch --flake .#<hostname> --no-write-lock-file

# Remote
sudo nixos-rebuild switch --flake github:lennihein/dotfiles#<hostname> --no-write-lock-file
```

### 2. Remote Server Deployment (`deploy-rs`)

To build and deploy to remote servers (e.g. `bes`):

```bash
# Local
nix run github:serokell/deploy-rs -- .#bes -- --no-write-lock-file

# Remote
nix run github:serokell/deploy-rs -- github:lennihein/dotfiles#bes -- --no-write-lock-file
```

### 3. Standalone Home Manager (Debian, Arch, Non-NixOS)

To apply standalone Home Manager (e.g. `debianwsl`, `archwsl`, `debian-headless`, `nixos`):

```bash
# Local
home-manager switch --flake .#<profile> --refresh --no-write-lock-file

# Remote
home-manager switch --flake github:lennihein/dotfiles#<profile> --refresh --no-write-lock-file
```

