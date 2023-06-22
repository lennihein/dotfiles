function orphans-clean --wraps='pacman -Qtdq' --description 'alias orphans-clean pacman -Qtdq'
  pacman -Qtdq $argv
        
end
