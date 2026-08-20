# dotfiles

Unified NixOS and Home Manager configuration monorepo with automated CI matrix builds and Cachix binary caching.

## Structure

- [**`hosts/`**](hosts/): NixOS system host definitions (`dell`, `ptah`, `anubis`, `bes`, `seth`, `sobek`, `wsl`).
- [**`modules/`**](modules/): NixOS system-level modules (DEs, services, drivers, networking).
- [**`home/`**](home/): Home Manager configurations and user dotfiles.
  - [**`home/common/`**](home/common/): Shared configuration across all systems (shell, git, vim, fastfetch, starship).
  - [**`home/configs/`**](home/configs/): Target-specific profiles (desktop, dev, debian, wsl, arch, guest).
  - [**`home/files/`**](home/files/): Static configuration assets.

## Usage

### 1. NixOS Systems

To apply on a NixOS host (e.g. `dell`, `ptah`, `anubis`, `bes`, `seth`, `sobek`, `wsl`):

```bash
# Local
doas nixos-rebuild switch --flake .#<hostname>

# Remote
doas nixos-rebuild switch --flake github:lennihein/dotfiles#<hostname>
```

### 2. Remote Server Deployment (`deploy-rs`)

Deploy to configured remote nodes (`anubis`, `bes`, `seth`, `sobek`):

```bash
# Deploy all configured nodes
nix run github:serokell/deploy-rs -- .

# Deploy a specific node (e.g. bes)
nix run github:serokell/deploy-rs -- .#bes

# Remote repository deployment
nix run github:serokell/deploy-rs -- github:lennihein/dotfiles
nix run github:serokell/deploy-rs -- github:lennihein/dotfiles#bes
```

### 3. Standalone Home Manager (Debian, Arch, Non-NixOS)

To apply standalone Home Manager (e.g. `debianwsl`, `archwsl`, `debian-headless`, `nixos`):

```bash
# Local
home-manager switch --flake .#<profile>

# Remote
home-manager switch --flake github:lennihein/dotfiles#<profile>
```

### 4. Flake Maintenance & CI

- **Evaluate flake without building:** `nix flake check`
- **Update all dependencies:** `nix flake update`
- **Update a specific input:** `nix flake lock --update-input <input>`
- **CI / Binary Cache:** GitHub Actions automatically tests builds across all hosts on push and caches them to [Cachix (`lennihein`)](https://app.cachix.org/cache/lennihein).
