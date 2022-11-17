if status is-interactive
    # Commands to run in interactive sessions can go here
end
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
source (/home/linuxbrew/.linuxbrew/Cellar/starship/1.11.0/bin/starship init fish --print-full-init | psub)
