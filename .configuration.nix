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
            lennihein = import (fetchTarball "https://github.com/lennihein/nixpkgs/archive/refs/heads/master.zip") {
                config = config.nixpkgs.config;
            };
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

    # dual boot with Windows
    time.hardwareClockInLocalTime = true;
    boot.supportedFilesystems = [ "ntfs" ];

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

    # podman
    virtualisation = {
        podman.enable = true;
        podman.dockerCompat = true;
    };
    
    # KVM
    virtualisation.libvirtd.enable = true;

    # Enable the X11 windowing system.
    services.xserver.enable = true;
    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.defaultSession = "gnome";
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # Configure keymap in X11
    services.xserver = {
        layout = "us";
        xkbVariant = "altgr-intl";
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

    # enable wireshark
    programs.wireshark.enable = true;

    # enabled fish
    programs.fish.enable = true;

    # define user
    users.users.lenni = {
        shell = pkgs.fish;
        isNormalUser = true;
        description = "Lenni Hein";
        extraGroups = [ "networkmanager" "wheel" "wireshark" "libvirtd" ];
        packages = with pkgs; [
            google-chrome
            neofetch
            ghidra
            lennihein.gitkraken
            python3
            gdu
            pwndbg
            htop
            ranger
            git
            starship
            rm-improved
            exa
            tldr
            vscode
            discord
            wireshark
            bat
            fzf
            tldr
            virt-manager
            direnv
            lennihein-22-11.hyper
            atool
        ];
    };

    # nerdfonts
    fonts.fonts = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Iosevka"]; })
    ];
    
    # enable doas
    security.doas.enable = true;
    security.doas.extraRules = [{
        users = [ "lenni" ];
        keepEnv = true;
        noPass = true;  
    }];
    
    # Enable automatic login for the user.
    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "lenni";

    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;

    # Enable nvidia (breaks some systems)
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.opengl.enable = true;
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    hardware.nvidia.modesetting.enable = true;
    
    # Disable wayland 
    services.xserver.displayManager.gdm.wayland = false;

    # # Hint Ozone to use Wayland
    # environment.sessionVariables.NIXOS_OZONE_WL = "1";
    # # Enable Fractional Scaling
    # services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    #     [org.gnome.mutter]
    #     experimental-features=['scale-monitor-framebuffer']
    # '';

    environment.systemPackages = with pkgs; [
        vim
        wget
        gnomeExtensions.appindicator
        pkgs.gnome3.gnome-tweaks
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
        gedit       # text editor
        simple-scan # document scanner
        totem       # video player
        yelp        # help viewer
        evince      # document viewer
        file-roller # archive manager
        geary       # email client
        seahorse    # password manager

        # these should be self explanatory
        gnome-calculator gnome-calendar gnome-characters  gnome-contacts
        gnome-font-viewer gnome-logs gnome-maps gnome-music
        gnome-disk-utility gnome-system-monitor pkgs.gnome-connections
        pkgs.gnome-tour pkgs.gnome-photos pkgs.gnome-console
        # gnome-clocks gnome-screenshot gnome-weather
    ];

    # register fish as a shell
    environment.shells = with pkgs; [fish];

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
    services.adguardhome.enable = false;

    # disable
    networking.firewall = {
        enable = false;
        # allowedTCPPorts = [ ... ];
        # allowedUDPPorts = [ ... ];
    };

    # automatic upgrades
    system.autoUpgrade.enable = true;
    # for unmanaged server enable this:
    system.autoUpgrade.allowReboot = false;
    # every day at 4am    
    system.autoUpgrade.dates = "*-*-* 4:00:00";

    # garbage collection
    nix.gc.automatic = true;
    nix.gc.dates = "weekly";
    nix.gc.options = "--delete-older-than 14d";

    # NixOS version
    system.stateVersion = "23.05";
}
