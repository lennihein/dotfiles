# Defined in - @ line 1
function winshut --wraps=/mnt/c/Windows/system32/shutdown.exe --wraps='/mnt/c/Windows/system32/shutdown.exe /s /t 5' --description 'alias winshut /mnt/c/Windows/system32/shutdown.exe /s /t 5'
  /mnt/c/Windows/system32/shutdown.exe /s /t 5 $argv;
end
