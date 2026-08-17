function init_x
    export DISPLAY=$(ip route show default | awk '{print $3}'):0.0
    export GDK_BACKEND=x11
end

abbr --add code "/mnt/c/Users/Lenni/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code"
abbr --add explorer "/mnt/c/Windows/explorer.exe"
abbr --add powershell "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"

abbr -- startx410 "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe 'Start-Process x410'"