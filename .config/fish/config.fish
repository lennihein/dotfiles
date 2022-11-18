#!/usr/bin/env fish

if status is-interactive
    # Commands to run in interactive sessions can go here
end

eval (starship init fish)

thefuck --alias | source

set -x DEBUGINFOD_URLS "https://debuginfod.archlinux.org"

set -x MANPAGER '/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
