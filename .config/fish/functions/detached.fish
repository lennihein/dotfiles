function detached
  $argv .&> /dev/null & && disown
end
