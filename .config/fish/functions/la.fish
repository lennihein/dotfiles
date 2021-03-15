# Defined in - @ line 1
function la --wraps='nu -c "ls -a"' --description 'alias la nu -c "ls -a"'
  nu -c "ls -a -d" $argv;
end
