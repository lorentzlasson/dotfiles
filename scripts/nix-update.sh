#!/usr/bin/env bash
set -euo pipefail

OLD=$(nix build --no-link --print-out-paths \
  ~/dotfiles/nix#nixosConfigurations.$(hostname).config.system.build.toplevel)
sudo nix flake update --flake ~/dotfiles/nix
NEW=$(nix build --no-link --print-out-paths \
  ~/dotfiles/nix#nixosConfigurations.$(hostname).config.system.build.toplevel)
HIGHLIGHTS=$(nix run nixpkgs#nvd -- --color=never diff "$OLD" "$NEW" \
  | grep --extended-regexp '^(\[U\*\]|\[A\+\]|\[R-\]|Closure size)' || true)
git add nix/flake.lock
git commit --message 'update nixos' --message "$HIGHLIGHTS"
