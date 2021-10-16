# I use Arch, btw
FROM archlinux/archlinux:base-devel

# installing some packages
RUN pacman -Syyu --noconfirm --needed\
    fish cmake gcc make neofetch net-tools nmap opendoas gdb pwndbg\
    python-pwntools traceroute valgrind git rustup thefuck libx11\
    fzf ranger vim starship ropgadget clang htop openvpn openssh\
    wget unzip bat pkg-config

# add user lenni with sudo and doas permits
RUN useradd -g wheel -m -s /usr/sbin/fish lenni\
    && echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers\
    && echo "permit nopass :wheel" >> /etc/doas.conf
USER lenni
WORKDIR /home/lenni

# set nightly as default toolchain for rust
RUN rustup default nightly

# install paru (and change AUR-order to descending)
RUN git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si --noconfirm && cd ../ && rm paru -rf
RUN sudo sh -c 'echo BottomUp >> /etc/paru.conf'

# install nushell
RUN paru -S nushell-bin gotop-bin --noconfirm

# copy config dotfiles
COPY --chown=lenni:lenni .config/ /home/lenni/.config/

# set pwndbg as default gdb frontend
RUN echo "source /usr/share/pwndbg/gdbinit.py" > /home/lenni/.gdbinit

# launnch fish as shell
CMD fish
