# Defined in - @ line 1
function gitclean --wraps='git clean -d -i -x' --description 'alias gitclean git clean -d -i -x'
  git clean -d -i -x $argv;
end
