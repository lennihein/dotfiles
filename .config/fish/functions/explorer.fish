# Defined in - @ line 1
function explorer --wraps=/mnt/c/Windows/explorer.exe --wraps='/mnt/c/Windows/explorer.exe .' --description 'alias explorer /mnt/c/Windows/explorer.exe .'
  /mnt/c/Windows/explorer.exe . $argv;
end
