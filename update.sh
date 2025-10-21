#!/bin/sh
cd ~/nixos-config
nix flake update
git commit -am update
git push --force-with-lease
cd -
