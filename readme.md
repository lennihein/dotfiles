# DEPRECATED

-> https://github.com/lennihein/home-manager

-> https://github.com/lennihein/nixos-config

# Install ArchWSL

## Install application

- [download .appx and .cer](https://github.com/yuk7/ArchWSL/releases)
- install .cer to the “Trusted Root Certificate Store” of the local machine
- install .appx

## Initialise

### fresh

```bash
# set root pw
passwd
# default user
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
useradd -m -G wheel -s /bin/bash lenni
passwd lenni
```

### from dotfiles

```bash
passwd

# we init keyring first
sudo rm -fr /etc/pacman.d/gnupg
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman -Syy archlinux-keyring
sudo pacman -Syyu
sudo pacman -S doas git fish openssh which base-devel

# grab dotfiles
cd /home
git clone https://github.com/lennihein/dotfiles.git
cd dotfiles
git checkout -b WSL
cd -
mv dotfiles lenni

# create user
useradd --home /home/lenni -G wheel -s $(which fish) lenni
# password
passwd lenni
# own
chown -R lenni:lenni lenni/


# permissions
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
echo "permit nopass lenni" > /etc/doas.conf
```

### from backup

```powershell
PS Arch.exe install full/path/to/backup.ext4.vhdx.gz
```

and you probably have to clean keyring

```bash
sudo rm -fr /etc/pacman.d/gnupg
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman -Syy archlinux-keyring
sudo pacman -Syyu
```

## Settings

```powershell
PS Arch.exe config --default-user lenni
PS Arch.exe config --append-path false
### should be default already
# PS Arch.exe config --wsl-version 2
# PS Arch.exe config --mount-drive true
```

## Install Packages

### Paru 
```bash
git clone https://aur.archlinux.org/paru-git.git && cd paru-git && makepkg -si --noconfirm && cd ../ && rm paru-git -rf
```

### Others

```bash
paru -S neofetch net-tools nmap thefuck starship ranger fzf wget unzip bat nushell traceroute btop gotop-bin cmake gdb pwndbg
echo "source /usr/share/pwndbg/gdbinit.py" > /home/lenni/.gdbinit
```

## Other configs

### /etc/paru.conf

```
# add these lines
BottomUp
CleanAfter
UpgradeMenu
NewsOnUpgrade
[bin]
Sudo = doas
```

### /opt/ghidra/support/launch.properties

```
...
VMARGS_LINUX=-Dsun.java2d.uiScale=2
...
```

### Make Gitkraken work

```
paru -S alsa-lib
```

### Windows Terminal

```
...
            {
                "antialiasingMode": "cleartype",
                "backgroundImage": null,
                "bellStyle": 
                [
                    "audible",
                    "window",
                    "taskbar"
                ],
                "closeOnExit": "always",
                "colorScheme": "Dracula",
                "commandline": "wsl.exe",
                "experimental.retroTerminalEffect": false,
                "font": 
                {
                    "face": "Pragmata Pro",
                    "size": 13
                },
                "guid": "{a5a97cb8-8961-5535-816d-772efe0c6a3f}",
                "hidden": false,
                "intenseTextStyle": "all",
                "name": "Arch",
                "opacity": 85,
                "padding": "15",
                "source": "Windows.Terminal.Wsl",
                "startingDirectory": "\\\\wsl.localhost\\Arch\\home\\lenni",
                "useAcrylic": true
            },
...
```

### VS Code

`settings.json`
```
{
    "editor.fontFamily": "IosevkaTerm Nerd Font Mono",
    "security.workspace.trust.untrustedFiles": "open",
    "editor.fontLigatures": true,
    "extensions.ignoreRecommendations": true,
    "workbench.statusBar.visible": true,
    "files.eol": "\n",
    "explorer.confirmDelete": false,
    "workbench.statusBar.feedback.visible": false,
    "terminal.integrated.cursorStyle": "line",
    "editor.cursorWidth": 2,
    "editor.minimap.renderCharacters": false,
    "editor.cursorSmoothCaretAnimation": "on",
    "editor.minimap.enabled": true,
    "files.exclude": {
        "**/.idea": true
    },
    "editor.guides.indentation": false,
    "telemetry.telemetryLevel": "off",
    "workbench.colorTheme": "Dracula",
    "window.zoomLevel": 1,
    "git.autofetch": true,
    "editor.inlineSuggest.enabled": true,
    "editor.suggestSelection": "first",
    "security.workspace.trust.enabled": false,
    "terminal.integrated.tabs.enabled": false,
}
```

keybindings.json
```
[
    {
        "key": "ctrl+shift+oem_3",
        "command": "workbench.action.terminal.toggleTerminal",
        "when": ""
    },
    {
        "key": "ctrl+oem_3",
        "command": "workbench.action.terminal.toggleTerminal",
        "when": ""
    },
    {
        "key": "ctrl+shift+oem_3",
        "command": "-workbench.action.terminal.new",
        "when": "terminalProcessSupported || terminalWebExtensionContributedProfile"
    }
]
```
