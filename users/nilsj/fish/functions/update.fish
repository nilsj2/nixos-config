function update --wraps="nix flake update && sudo nixos-rebuild switch --flake . && sudo nix-collect-garbage --delete-older-than 3d && git commit -am 'update' && git push --force-with-lease" --description "alias update nix flake update && sudo nixos-rebuild switch --flake . && sudo nix-collect-garbage --delete-older-than 3d && git commit -am 'update' && git push --force-with-lease"
    cd ~/nixos-config && nix flake update && git commit -am update && git push --force-with-lease && cd -

end
