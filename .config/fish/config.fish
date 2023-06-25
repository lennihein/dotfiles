if status is-interactive
    # Commands to run in interactive sessions can go here
end

export GDK_BACKEND=x11

export GDK_SCALE=2
export QT_SCALE_FACTOR=2

source (starship init fish --print-full-init | psub)

set -x MANPAGER '/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
