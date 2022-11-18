# Defined in - @ line 1
function open --wraps='nu -c "open"' --description 'alias open nu -c "open"'
  bat $argv;
end
