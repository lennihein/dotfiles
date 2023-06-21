function nixos-env --wraps='pls nix-env -p /nix/var/nix/profiles/system' --description 'alias nixos-env pls nix-env -p /nix/var/nix/profiles/system'
  pls nix-env -p /nix/var/nix/profiles/system $argv
        
end
