function despec --wraps='pls switch /nix/var/nix/profiles/system/bin/switch-to-configuration switch' --description 'alias despec pls switch /nix/var/nix/profiles/system/bin/switch-to-configuration switch'
  pls /nix/var/nix/profiles/system/bin/switch-to-configuration switch $argv
        
end
