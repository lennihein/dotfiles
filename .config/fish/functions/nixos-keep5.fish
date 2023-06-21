function nixos-keep5 --wraps='pls nix-env -p /nix/var/nix/profiles/system --delete-generations +5' --description 'alias nixos-keep5 pls nix-env -p /nix/var/nix/profiles/system --delete-generations +5'
  pls nix-env -p /nix/var/nix/profiles/system --delete-generations +5 $argv
        
end
