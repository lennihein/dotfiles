if status is-interactive
    # Commands to run in interactive sessions can go here
end

export DISPLAY=(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
export GDK_BACKEND=x11

export GDK_SCALE=2
export QT_SCALE_FACTOR=2

eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
source (/home/linuxbrew/.linuxbrew/Cellar/starship/1.11.0/bin/starship init fish --print-full-init | psub)
