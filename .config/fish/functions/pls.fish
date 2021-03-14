# Defined in - @ line 1
function pls --wraps=doas --description 'alias pls doas'
  doas  $argv;
end
