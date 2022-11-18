#!/usr/bin/env fish

if status is-interactive
    # Commands to run in interactive sessions can go here
end

export DISPLAY=(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
export GDK_BACKEND=x11

export GDK_SCALE=2
export QT_SCALE_FACTOR=2

eval (starship init fish)

thefuck --alias | source

set -x DEBUGINFOD_URLS "https://debuginfod.archlinux.org"

set -x MANPAGER '/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
