# Defined in - @ line 1
function lsla --wraps='nu -c "ls -la"' --description 'alias lsla nu -c "ls -la"'
  nu -c "ls -la -d" $argv;
end
