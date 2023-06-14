function nix-generations --wraps='pls nix-env -p /nix/var/nix/profiles/system --list-generations' --description 'alias nix-generations pls nix-env -p /nix/var/nix/profiles/system --list-generations'
  pls nix-env -p /nix/var/nix/profiles/system --list-generations $argv
        
end
