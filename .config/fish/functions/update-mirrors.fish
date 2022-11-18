function update-mirrors --wraps='pls reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist' --description 'alias update-mirrors pls reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist'
  pls reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist $argv; 
end
