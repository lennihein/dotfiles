{ config, pkgs, lib, ... }:

{
    imports =
        [
            /etc/nixos/device.nix
            /etc/nixos/hardware-configuration.nix
        ];
   
    nixpkgs.config = {
        # allow unfree packages
        allowUnfree = true;
        # add old nixpkgs
        packageOverrides = pkgs: {
            # you can either ref a nix-channel:
            unstable = import <nixos-unstable> {
                config = config.nixpkgs.config;
            };
            # or a tarball:
            lennihein-22-11 = import (fetchTarball "https://github.com/lennihein/nixpkgs/archive/refs/heads/nixos-22.11.zip") {
                config = config.nixpkgs.config;
            };
            # warp-beta = import (fetchTarball "https://github.com/imadnyc/nixpkgs/archive/refs/heads/warp-terminal-initial-linux.zip") {
            #     config = config.nixpkgs.config;  
            # };
            warp = import (fetchTarball "https://github.com/lennihein/nixpkgs/archive/71f6d0f5e441be3c283fb81989180f04da5049f6.zip") {
                config = config.nixpkgs.config;  
            };
            # lennihein = import (fetchTarball "https://github.com/lennihein/nixpkgs/archive/refs/heads/master.zip") {
            #    config = config.nixpkgs.config;
            # };
        };
    };

    # enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Bootloader
    # system.nixos.label = "NixOS";
    # system.nixos.tags = ["BSI"]; # only works if label is disabled
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    # latest kernel
    # boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.loader.grub.efiSupport = true;
    boot.loader.efi.canTouchEfiVariables = true;
    # boot.loader.grub.useOSProber = true; # we don't need, since we don't have SecureBoot anyway
    boot.plymouth.enable = true;

    ########################################################################

    # Disable wayland 
    services.xserver.displayManager.gdm.wayland = false;
    # enable NVIDIA
    services.xserver.videoDrivers = [ "nvidia" ];
    # Enable OpenGL
    hardware.opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
    };
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable; # or .production;
    hardware.nvidia.powerManagement.enable = true;
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia.forceFullCompositionPipeline = true;
    hardware.nvidia.nvidiaSettings = true;

    ########################################################################

    specialisation.latex.configuration = {
        system.nixos.tags = ["latex"];
        # define user
        users.users.lenni = {
            packages = with pkgs; [
                # tex
                texlive.combined.scheme-full
                texstudio
                inkscape-with-extensions # for svgs
            ];
        };
    }; 

    specialisation.vbox.configuration = {
        system.nixos.tags = ["vbox"];
        # disable KVM
        virtualisation.libvirtd.enable = lib.mkForce false;
        # enable virtualbox
        virtualisation.virtualbox.host.enable = true;
        virtualisation.virtualbox.host.enableExtensionPack = true;
        users.groups.vbox.members = [ "lenni" ];
    };

    specialisation.ucontroller.configuration = {
        system.nixos.tags = ["ucontroller"];
        # udev rules for uController
        services.udev.extraRules = ''
            ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE="664", GROUP="plugdev"
        '';
        # and add user to plugdev group
        users.groups.plugdev.members = [ "lenni" ];
        users.groups.dialout.members = [ "lenni" ];
        # ucontroller packages
        users.users.lenni = {
            packages = with pkgs; [
                cutecom usbutils gcc-arm-embedded openocd
            ];
        };
    };

    # dual boot with Windows
    time.hardwareClockInLocalTime = true;
    boot.supportedFilesystems = [ "ntfs" ];

    # ignore lid switch when on AC
    services.logind.extraConfig = ''
        HandleLidSwitchExternalPower=ignore
    '';

    # enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "de_DE.UTF-8";
        LC_IDENTIFICATION = "de_DE.UTF-8";
        LC_MEASUREMENT = "de_DE.UTF-8";
        LC_MONETARY = "de_DE.UTF-8";
        LC_NAME = "de_DE.UTF-8";
        LC_NUMERIC = "de_DE.UTF-8";
        LC_PAPER = "de_DE.UTF-8";
        LC_TELEPHONE = "de_DE.UTF-8";
        LC_TIME = "de_DE.UTF-8";
    };

    # Ozone and fractional scaling
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer']
    '';

    # Enable the X11 windowing system.
    services.xserver.enable = true;
    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.defaultSession = "gnome";
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    # disable gnome keyring
    services.gnome.gnome-keyring.enable = lib.mkForce false;

    # HiDPI support
    environment.variables = {
        _JAVA_OPTIONS = "-Dsun.java2d.uiScale=1";
    };

    # Enable automatic login for the user.
    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "lenni";

    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
    
    # GNOME settings daemon
    services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

    # virtualisation
    virtualisation.podman.enable = true;
    virtualisation.libvirtd.enable = false;

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
        variant = "altgr-intl";
    };

    # Flat mouse profile
    services.xserver.libinput = {
        enable = true;
        mouse.accelProfile = "flat";
    };

    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # enable doas
    security.doas.enable = true;
    security.doas.extraRules = [{
        users = [ "lenni" ];
        keepEnv = true;
        noPass = true;  
    }];

    # enable packages
    programs.wireshark.enable = true;
    programs.fish.enable = true;
    programs.vim.defaultEditor = true;
    programs.git.enable = true;
    programs.xonsh.enable = true;
    # programs.steam.enable = true;
    programs.dconf.enable = true;

    # register fish as a shell
    environment.shells = with pkgs; [fish];

    # define user
    users.users.lenni = {
        shell = pkgs.fish;
        isNormalUser = true;
        description = "Lenni Hein";
        extraGroups = [ "networkmanager" "wheel" "wireshark" "libvirtd"];
        packages = with pkgs; [
            # requires config
            helix starship kitty zoxide
            
            # dev tools
            ghidra unstable.gitkraken wireshark unstable.vscode lennihein-22-11.hyper virt-manager meld warp.warp-terminal
            
            # others
            google-chrome discord
        ];
    };

    environment.systemPackages = with pkgs; [
        # essentials
        wget
        lsof dig file
        atool unzip
        python3 gnumake cmake clang gcc
        
        # command line tools 
        htop bottom gdu neofetch ranger tldr gitui bat fzf ripgrep pwndbg rm-improved eza nvd direnv procs fd duf
        
        # bottles
        # bottles
        
        # add terminal instead of console
        gnome.gnome-terminal
        
        # gnome essentials
        pkgs.gnome3.gnome-tweaks
        gnomeExtensions.appindicator
        gnomeExtensions.no-a11y
        gnomeExtensions.trimmer
        gnomeExtensions.clipboard-indicator
        
        # menu and panel
        gnomeExtensions.arcmenu
        gnomeExtensions.dash-to-panel

        # monitoring
        gnomeExtensions.vitals
        # gnomeExtensions.docker
        # gnomeExtensions.sermon
        
        # visual candy
        # gnomeExtensions.blur-my-shell
        # gnomeExtensions.just-perfection
        # gnomeExtensions.glasa
        
        # alternative to dash to panel
        # gnomeExtensions.rocketbar
        
        # Dock
        # gnomeExtensions.dock-from-dash
        # gnomeExtensions.overview-dash-hide
    ];
    
    # disable manual
    documentation.nixos.enable = false;

    # disable xterm
    services.xserver.excludePackages = [ pkgs.xterm ];

    # disable optional gnome bloat
    environment.gnome.excludePackages = with pkgs.gnome; [
        baobab      # disk usage analyzer
        cheese      # photo booth
        eog         # image viewer
        epiphany    # web browser
        simple-scan # document scanner
        totem       # video player
        yelp        # help viewer
        evince      # document viewer
        file-roller # archive manager
        geary       # email client
        seahorse    # password manager
        pkgs.snapshot    # camera

        # these should be self explanatory
        gnome-calculator gnome-calendar gnome-characters gnome-contacts
        gnome-font-viewer gnome-logs gnome-maps gnome-music
        gnome-disk-utility gnome-system-monitor pkgs.gnome-connections
        pkgs.gnome-tour pkgs.gnome-photos pkgs.gnome-console

        # I want these
        # gnome-clocks gnome-screenshot gnome-weather
    ];

    # nerdfonts
    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Iosevka"]; })
    ];

    # Enable the OpenSSH daemon.
    services.openssh = {
        enable = false;
        settings = {
            X11Forwarding = true;
            GatewayPorts = "yes";
            PasswordAuthentication = false;
            PermitRootLogin = "no";
            KbdInteractiveAuthentication = false;
        };
    };

    # AdGuard Home
    services.adguardhome.enable = true;
    networking.nameservers = [ "127.0.0.1" ];

    # disable
    networking.firewall = {
        enable = true;
        # allowedTCPPorts = [ ... ];
        # allowedUDPPorts = [ ... ];
    };

    # automatic upgrades
    # system.autoUpgrade.enable = true;
    # for unmanaged server enable this:
    # system.autoUpgrade.allowReboot = false;
    # every day at 4am    
    # system.autoUpgrade.dates = "*-*-* 4:00:00";

    # Dedupe the Nix store
    nix.settings.auto-optimise-store = true;

    # garbage collection
    # nix.gc.automatic = true;
    # nix.gc.dates = "*-*-* 4:00:00";
    # without options it will only clean the store, not delete old generations
    # nix.gc.options = "--delete-older-than 14d";

    # NixOS version
    system.stateVersion = "23.05";
}
