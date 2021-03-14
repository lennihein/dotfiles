# Defined in - @ line 1
function allpackages --wraps=pacman\ -Qq\ \|\ fzf\ --preview\ \'pacman\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(pacman\ -Qil\ \{\}\ \|\ less\)\'\ \; --description alias\ allpackages\ pacman\ -Qq\ \|\ fzf\ --preview\ \'pacman\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(pacman\ -Qil\ \{\}\ \|\ less\)\'\ \;
  pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)' ; $argv;
end
