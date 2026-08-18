{
  description = "Lenni's NixOS & Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    pwndbg.url = "github:pwndbg/pwndbg";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-master,
      pwndbg,
      home-manager,
      nixos-wsl,
      deploy-rs,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgsStable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgsMaster = import nixpkgs-master {
        inherit system;
        config.allowUnfree = true;
      };

      sharedSpecialArgs = {
        inherit pkgsStable pkgsMaster;
        pwndbg = pwndbg.packages.${system}.pwndbg;
      };

      mkHome = modules: home-manager.lib.homeManagerConfiguration {
        inherit pkgs modules;
        extraSpecialArgs = sharedSpecialArgs;
      };
    in
    {
      # ==========================================
      # NixOS Host Configurations
      # ==========================================
      nixosConfigurations = {
        dell = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit pkgsStable; };
          modules = [
            ./modules/common
            ./modules/laptop/default.nix
            ./modules/desktop-environment/default.nix
            ./modules/uncommon/boot.nix
            ./modules/uncommon/podman.nix
            ./modules/uncommon/kvm.nix
            ./modules/uncommon/wireshark.nix
            ./modules/uncommon/tpm.nix
            ./modules/uncommon/ssh.nix
            ./modules/uncommon/printing.nix
            ./hosts/dell/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = sharedSpecialArgs;
              home-manager.users.lenni = {
                imports = [
                  ./home/common/default.nix
                  ./home/configs/dev.nix
                  ./home/configs/desktop.nix
                  ./home/configs/nixos.nix
                ];
              };
            }
          ];
        };

        ptah = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit pkgsStable; };
          modules = [
            ./modules/common
            ./modules/laptop/default.nix
            ./modules/desktop-environment/default.nix
            ./modules/uncommon/boot.nix
            ./modules/uncommon/podman.nix
            ./modules/uncommon/kvm.nix
            ./modules/uncommon/wireshark.nix
            ./modules/uncommon/tpm.nix
            ./modules/uncommon/adguard.nix
            ./modules/uncommon/printing.nix
            ./hosts/ptah/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = sharedSpecialArgs;
              home-manager.users.lenni = {
                imports = [
                  ./home/common/default.nix
                  ./home/configs/dev.nix
                  ./home/configs/desktop.nix
                  ./home/configs/nixos.nix
                ];
              };
            }
          ];
        };

        bes = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit pkgsStable; };
          modules = [
            ./modules/common
            ./hosts/bes/default.nix
            ./hosts/bes/hardware-configuration.nix
            ./modules/uncommon/podman.nix
            ./modules/uncommon/ssh.nix
            ./modules/uncommon/headscale.nix
            ./modules/uncommon/gitea.nix
            ./modules/uncommon/nix-store.nix
            ./modules/uncommon/adguard.nix
            ./modules/uncommon/filebrowser.nix
            ./modules/uncommon/linx-server.nix
            ./modules/uncommon/authelia.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = sharedSpecialArgs;
              home-manager.users.lenni = {
                imports = [
                  ./home/common/default.nix
                  ./home/configs/nixos.nix
                ];
              };
            }
          ];
        };

        wsl = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit pkgsStable; };
          modules = [
            nixos-wsl.nixosModules.default
            ./modules/common
            ./hosts/wsl/default.nix
            ./modules/uncommon/nix-store.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = sharedSpecialArgs;
              home-manager.users.lenni = {
                imports = [
                  ./home/common/default.nix
                  ./home/configs/dev.nix
                  ./home/configs/wsl.nix
                  ./home/configs/nixos.nix
                ];
              };
            }
          ];
        };
      };

      # ==========================================
      # Standalone Home Manager Configurations
      # ==========================================
      homeConfigurations = {
        debianwsl = mkHome [
          ./home/common/default.nix
          ./home/configs/dev.nix
          ./home/configs/guest.nix
          ./home/configs/wsl.nix
          ./home/configs/wsl_old.nix
          ./home/configs/debian.nix
        ];

        archwsl = mkHome [
          ./home/common/default.nix
          ./home/configs/dev.nix
          ./home/configs/guest.nix
          ./home/configs/wsl.nix
          ./home/configs/wsl_old.nix
          ./home/configs/arch.nix
          ./home/configs/archwsl.nix
        ];

        debian-headless = mkHome [
          ./home/common/default.nix
          ./home/configs/guest.nix
          ./home/configs/debian.nix
        ];

        nixos = mkHome [
          ./home/common/default.nix
          ./home/configs/dev.nix
          ./home/configs/desktop.nix
          ./home/configs/nixos.nix
        ];
      };

      # Optional module exports
      nixosModules = {
        default = { ... }: {
          imports = [
            ./home/common/default.nix
            ./home/configs/dev.nix
            ./home/configs/desktop.nix
            ./home/configs/nixos.nix
          ];
        };
        headless = { ... }: {
          imports = [
            ./home/common/default.nix
            ./home/configs/nixos.nix
          ];
        };
        wsl = { ... }: {
          imports = [
            ./home/common/default.nix
            ./home/configs/dev.nix
            ./home/configs/wsl.nix
            ./home/configs/nixos.nix
          ];
        };
      };

      # ==========================================
      # Deploy-RS Deployment Configuration
      # ==========================================
      deploy.nodes.bes = {
        hostname = "bes.lennihein.com";
        sshUser = "lenni";
        user = "root";
        sudo = "doas -u";
        autoRollback = false;
        profiles.system = {
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.bes;
        };
      };

      # Deploy-rs checks
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
