function kraken --wraps='gitkraken . &> /dev/null & && disown' --description 'alias kraken gitkraken . &> /dev/null & && disown'
  gitkraken . &> /dev/null & && disown $argv; 
end
