if status is-interactive
    # Commands to run in interactive sessions can go here
end

eval (starship init fish)

set -x MANPAGER 'bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c     \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

set -Ux EDITOR hx

set -g fish_greeting

# silent direnv
set -x DIRENV_LOG_FORMAT ""
# enable direnv
direnv hook fish | source

# zoxide
zoxide init --cmd cd fish | source
