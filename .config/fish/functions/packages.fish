function packages --wraps=nix-store\ -q\ --references\ /var/run/current-system/sw\ \|\ cut\ -d\'-\'\ -f2- --description alias\ packages\ nix-store\ -q\ --references\ /var/run/current-system/sw\ \|\ cut\ -d\'-\'\ -f2-
  nix-store -q --references /var/run/current-system/sw | cut -d'-' -f2- $argv
        
end
