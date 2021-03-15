# Defined in /home/lenni/.config/fish/functions/ls.fish @ line 2
function ls --wraps='nu -c "ls"' --description 'alias ls nu -c "ls"'
  nu -c "ls -d" $argv;
end
