function kitty --wraps='/usr/sbin/kitty &; disown (pidof /usr/sbin/kitty); exit' --description 'alias kitty /usr/sbin/kitty &; disown (pidof /usr/sbin/kitty); exit'
  /usr/sbin/kitty &; disown (pidof /usr/sbin/kitty); exit $argv; 
end
