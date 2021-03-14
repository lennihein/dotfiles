# Defined in - @ line 1
function orphans --wraps='pacman -Qttdq' --description 'alias orphans pacman -Qttdq'
  pacman -Qttdq $argv;
end
