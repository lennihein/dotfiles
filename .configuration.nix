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
            # lennihein = import (fetchTarball "https://github.com/lennihein/nixpkgs/archive/refs/heads/master.zip") {
            #     config = config.nixpkgs.config;
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

    # virtualisation
    virtualisation.podman.enable = true;
    virtualisation.libvirtd.enable = true;

    # Configure keymap in X11
    services.xserver = {
        layout = "us";
        xkbVariant = "altgr-intl";
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

    # register fish as a shell
    environment.shells = with pkgs; [fish];

    # define user
    users.users.lenni = {
        shell = pkgs.fish;
        isNormalUser = true;
        description = "Lenni Hein";
        extraGroups = [ "networkmanager" "wheel" "wireshark" "libvirtd" ];
        packages = with pkgs; [
            # requires config
            helix starship
            
            # dev tools
            ghidra gitkraken wireshark vscode lennihein-22-11.hyper virt-manager

            # others
            google-chrome discord   
        ];
    };

    environment.systemPackages = with pkgs; [
        # essentials
        wget
        lsof dig
        atool unzip
        python3 gnumake cmake
        
        # command line tools 
        htop gdu neofetch ranger tldr gitui bat fzf ripgrep pwndbg rm-improved exa nvd direnv
        
        # gnome essentials
        pkgs.gnome3.gnome-tweaks
        gnomeExtensions.appindicator
        gnomeExtensions.no-a11y
        gnomeExtensions.clipman
        
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
        gedit       # text editor
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
        pkgs.gnome-tour pkgs.gnome-photos

        # I want these
        # gnome-clocks gnome-screenshot gnome-weather pkgs.gnome-console
    ];

    # nerdfonts
    fonts.fonts = with pkgs; [
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

    # Dedupe the Nix store
    nix.settings.auto-optimise-store = true;

    # garbage collection
    nix.gc.automatic = true;
    nix.gc.dates = "*-*-* 4:00:00";
    # without options it will only clean the store, not delete old generations
    # nix.gc.options = "--delete-older-than 14d";

    # NixOS version
    system.stateVersion = "23.05";
}
