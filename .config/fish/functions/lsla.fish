function lsla --wraps='nu -c "ls -la"' --wraps='exa -la' --description 'alias lsla exa -la'
  exa -la $argv; 
end
