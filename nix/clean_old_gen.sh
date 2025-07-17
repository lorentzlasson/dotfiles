#!/usr/bin/env sh

sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
sudo nix-env --delete-generations +3 --profile /nix/var/nix/profiles/system
sudo nixos-rebuild boot --flake ~/dotfiles/nix
