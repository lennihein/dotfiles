# Defined in - @ line 1
function ff --wraps=fzf\ --preview\ \'/bin/bat\ \{\}\ --color=always\' --description alias\ ff\ fzf\ --preview\ \'/bin/bat\ \{\}\ --color=always\'
  fzf --preview '/bin/bat {} --color=always --theme Dracula' $argv;
end
