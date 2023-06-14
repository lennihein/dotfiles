# I use Arch, btw
FROM archlinux/archlinux:base-devel

# update
RUN pacman -Syyu --noconfirm

# installing some packages
RUN pacman -S --noconfirm --needed\
    fish cmake gcc make neofetch net-tools nmap opendoas gdb pwndbg\
    traceroute valgrind git rustup thefuck libx11\
    fzf ranger vim starship clang htop openssh\
    wget unzip atool bat pkg-config nushell ncdu gdu btop duf exa

# fix
RUN chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo

# add user lenni with sudo and doas permits
RUN useradd -g wheel -m -s /usr/sbin/fish lenni\
    && echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers\
    && echo "permit nopass :wheel" >> /etc/doas.conf
USER lenni
WORKDIR /home/lenni

# install paru (and change AUR-order to descending)
RUN git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && makepkg -si --noconfirm && cd ../ && rm paru-bin -rf

RUN rustup default stable 

RUN sudo sh -c 'echo BottomUp >> /etc/paru.conf'

RUN paru -S rm-improved

# copy config dotfiles
COPY --chown=lenni:wheel .config/ /home/lenni/.config/

# set pwndbg as default gdb frontend
RUN echo "source /usr/share/pwndbg/gdbinit.py" > /home/lenni/.gdbinit

# launch fish as shell
CMD fish
