{ config, pkgs, ... }:

{
    imports =
        [
            /etc/nixos/hardware-configuration.nix
        ];

    # Bootloader
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    boot.loader.grub.efiSupport = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub.useOSProber = true;

    # dual boot with Windows
    time.hardwareClockInLocalTime = true;

    # set hostname
    networking.hostName = "Thinkpad"; 

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

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
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
        description = "Lenni";
        extraGroups = [ "networkmanager" "wheel" "wireshark" ];
        packages = with pkgs; [
            google-chrome
            neofetch
            ghidra
	    gitkraken
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
	    # direnv
        ];
    };
    
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

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # # enable nvidia
    # services.xserver.videoDrivers = [ "nvidia" ];
    # hardware.opengl.enable = true;

    # # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

    # # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
    # hardware.nvidia.modesetting.enable = true;

    environment.systemPackages = with pkgs; [
        vim
        wget
        gnomeExtensions.appindicator
        pkgs.gnome3.gnome-tweaks
    ];

    # disable xterm
    services.xserver.excludePackages = [ pkgs.xterm ];
    # diable cups
    services.printing.enable = false;

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
        gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-contacts
        gnome-font-viewer gnome-logs gnome-maps gnome-music gnome-screenshot
        gnome-system-monitor gnome-weather gnome-disk-utility pkgs.gnome-connections
        pkgs.gnome-tour pkgs.gnome-photos
    ];

    # # something about the system tray, not needed?
    # services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

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

    # # Enable the X11 forwarding.
    # programs.ssh.forwardX11 = true;
    # programs.ssh.setXAuthLocation = true;

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
    

    # NixOS version
    system.stateVersion = "23.05";
}
