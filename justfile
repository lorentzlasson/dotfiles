default:
  @just --list

stow:
  stow .

unstow:
  stow --delete .

restow:
  stow --restow .

sync:
  ./scripts/sync.sh

nix-update:
  ./scripts/nix-update.sh

claude-code-update:
  #!/usr/bin/env bash
  set -euo pipefail
  ver() { nix eval --raw "github:ryoppippi/claude-code-overlay/$(jq --raw-output '.nodes."claude-code-overlay".locked.rev' ~/dotfiles/nix/flake.lock)#packages.x86_64-linux.claude.version"; }
  old=$(ver)
  sudo nix flake update claude-code-overlay --flake ~/dotfiles/nix
  sudo nixos-rebuild switch --flake ~/dotfiles/nix
  new=$(ver)
  git diff --quiet nix/flake.lock || git commit nix/flake.lock --message "update claude code" --message "v$old -> v$new"

nix-rebuild:
  sudo nixos-rebuild switch --flake ~/dotfiles/nix

nix-boot:
  sudo nixos-rebuild boot --flake ~/dotfiles/nix

nix-generations:
  sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

nix-cleanup:
  sudo nix-env --delete-generations +3 --profile /nix/var/nix/profiles/system
  sudo nixos-rebuild boot --flake ~/dotfiles/nix
  sudo nix-collect-garbage

hardware-sync machine=`hostname`:
  sudo nixos-generate-config
  cp /etc/nixos/hardware-configuration.nix ~/dotfiles/nix/{{machine}}/hardware-configuration.nix
  just static-fix

update-all: nix-update nix-rebuild stow

static-qa:
  ./scripts/static-qa.sh

static-fix:
  ./scripts/static-fix.sh
