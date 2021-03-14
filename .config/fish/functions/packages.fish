# Defined in - @ line 1
function packages --wraps=pacman\ -Qentq\ \|\ fzf\ --preview\ \'pacman\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(pacman\ -Qil\ \{\}\ \|\ less\)\' --description alias\ packages\ pacman\ -Qq\ \|\ fzf\ --preview\ \'pacman\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(pacman\ -Qil\ \{\}\ \|\ less\)\'
  pacman -Qetq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)' $argv;
end
