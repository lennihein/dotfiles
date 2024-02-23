{ config, pkgs, ... }:

{
    imports =
        [
            /etc/nixos/device.nix
            /etc/nixos/hardware-configuration.nix
        ];

    # put this into device.nix
    # networking.hostName = "NixOS";  
    
    nixpkgs.config = {
        # allow unfree packages
        allowUnfree = true;
        # add old nixpkgs
        packageOverrides = pkgs: {
            # you can either ref a nix-channel:
            # old = import <nixpkgs-old> {
            # or a tarball:
            lennihein-22-11 = import (fetchTarball "https://github.com/lennihein/nixpkgs/archive/refs/heads/nixos-22.11.zip") {
                config = config.nixpkgs.config;
            };
            warp-beta = import (fetchTarball "https://github.com/imadnyc/nixpkgs/archive/refs/heads/warp-terminal-initial-linux.zip") {
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
    # system.nixos.label = "LostNix";
    system.nixos.tags = [];
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.loader.grub.efiSupport = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub.useOSProber = true;
    boot.plymouth.enable = true;

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

    # Enable nvidia (breaks some systems)
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.opengl.enable = true;
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    hardware.nvidia.powerManagement.enable = true;
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia.forceFullCompositionPipeline = true;

    # Disable wayland 
    services.xserver.displayManager.gdm.wayland = false;

    # Enable the X11 windowing system.
    services.xserver.enable = true;
    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.defaultSession = "gnome";
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # HiDPI support
    environment.variables = {
        _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    };

    # Enable automatic login for the user.
    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "lenni";

    # udev rules for uController
    services.udev.extraRules = ''
        ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE="664", GROUP="plugdev"
    '';
    # and add user to plugdev group
    users.groups.plugdev.members = [ "lenni" ];

    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
    
    # GNOME settings daemon
    services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

    # virtualisation
    virtualisation.podman.enable = true;
    virtualisation.libvirtd.enable = true;

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
    programs.steam.enable = true;
    programs.dconf.enable = true;

    # register fish as a shell
    environment.shells = with pkgs; [fish];

    # define user
    users.users.lenni = {
        shell = pkgs.fish;
        isNormalUser = true;
        description = "Lenni Hein";
        extraGroups = [ "networkmanager" "wheel" "wireshark" "libvirtd" "dialout"];
        packages = with pkgs; [
            # requires config
            helix starship kitty
            
            # dev tools
            ghidra gitkraken wireshark vscode lennihein-22-11.hyper virt-manager meld warp-beta.warp-terminal

            # tex
            # texlive.combined.scheme-full
            # texstudio
            # inkscape-with-extensions # for svgs
            
            # others
            google-chrome discord

            # ucontroller
            cutecom usbutils gcc-arm-embedded openocd stlink stlink-gui
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
        bottles
        
        # add terminal instead of console
        gnome.gnome-terminal
        
        # gnome essentials
        pkgs.gnome3.gnome-tweaks
        gnomeExtensions.appindicator
        gnomeExtensions.no-a11y
        # gnomeExtensions.clipman
        
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
        enable = true;
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

    # disable
    networking.firewall = {
        enable = false;
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
