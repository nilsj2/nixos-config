function nxsh --wraps='nix-shell --run fish -p' --description 'alias nxsh=nix-shell --run fish -p'
  nix-shell --run fish -p $argv
        
end
