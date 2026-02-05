default:
  @just --list

stow:
  stow .

unstow:
  stow --delete .

restow:
  stow --restow .

sync:
  git pull
  git push

nix-update:
  sudo nix flake update --flake ~/dotfiles/nix
  git add nix/flake.lock
  git commit --message 'update nixos'

claude-code-update:
  sudo nix flake update claude-code-overlay --flake ~/dotfiles/nix
  sudo nixos-rebuild switch --flake ~/dotfiles/nix

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
