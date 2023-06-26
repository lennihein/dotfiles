function nix-diff --wraps='nvd diff /nix/var/nix/profiles/system-{}-link/' --description 'alias nix-diff nvd diff /nix/var/nix/profiles/system-{}-link/'
  nvd diff /nix/var/nix/profiles/system-{$argv}-link/
        
end
