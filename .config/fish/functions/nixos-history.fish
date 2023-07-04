function nixos-history --wraps='nix profile diff-closures --profile /nix/var/nix/profiles/system' --description 'alias nixos-history nix profile diff-closures --profile /nix/var/nix/profiles/system'
  nix profile diff-closures --profile /nix/var/nix/profiles/system $argv
        
end
