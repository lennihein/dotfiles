if status is-interactive
    # Commands to run in interactive sessions can go here
end

export QT_SCALE_FACTOR=2
export GDK_SCALE=2
export GDK_BACKEND=x11
source (starship init fish --print-full-init | psub)