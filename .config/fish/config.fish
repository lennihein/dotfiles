if status is-interactive
    # Commands to run in interactive sessions can go here
end

source (starship init fish --print-full-init | psub)
