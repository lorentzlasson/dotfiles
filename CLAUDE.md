# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive dotfiles repository managing both NixOS system configurations and user application configurations. It uses a hybrid approach with NixOS flakes for system management and GNU Stow for user dotfiles.

## Architecture

### NixOS Configuration Structure
- `nix/flake.nix` - Main configuration defining 4 machines: xps15, xps13, asus (desktops) and nuc (server)
- Base configurations: `pc/` for desktops with GNOME/gaming, `server/` for minimal server setup
- Docker is available on all machines via base configuration
- Machine configs inherit from base + add hostname and hardware-configuration.nix
- Package lists: `pc/packages.nix` (77 packages), `server/packages.nix` (45 packages)

### Key Directories
- `nix/{machine}/` - Machine-specific configs (hostname, hardware)
- `nix/pc/` - Desktop base config (GNOME, Steam, GUI apps)  
- `nix/server/` - Server base config (Nginx, Grafana, Prometheus, Blocky DNS)
- `nix/configuration.nix` - Base config for all machines (Docker, basic tools)
- `.config/` - User application configs managed via Stow

## Common Commands

### NixOS System Management
```bash
# Update and rebuild system
sudo nix flake update --flake ~/dotfiles/nix
sudo nixos-rebuild switch --flake ~/dotfiles/nix

# Maintenance - delete old generations and collect garbage
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
sudo nix-env --delete-generations +3 --profile /nix/var/nix/profiles/system
sudo nixos-rebuild boot --flake ~/dotfiles/nix
sudo nix-collect-garbage
```

### Dotfiles Setup
```bash
cd ~
git clone https://github.com/lorentzlasson/dotfiles
rm ~/.config  # Remove symlink if exists
mkdir -p ~/.config
cd dotfiles
stow .
```

### Hardware Configuration Updates
```bash
# Update hardware config (run on target machine)
sudo nixos-generate-config
cp /etc/nixos/hardware-configuration.nix ~/dotfiles/nix/{machine}/hardware-configuration.nix
```

## Important Files

- `nix/flake.nix` - System entry point, all machine definitions
- `nix/pc/configuration.nix` - Desktop configuration template
- `nix/server/configuration.nix` - Server configuration template  
- `.zshrc` - Shell configuration with vi-mode and custom prompt
- `.config/shell/{aliases,functions}.sh` - Shell productivity enhancements
- `.config/nvim/init.lua` - Neovim configuration entry point
- `.gitconfig` - Git configuration with 50+ custom aliases

## Machine Configurations

- **Desktop machines** (xps15, xps13, asus): Full development environment with GNOME, Steam
- **Server machine** (nuc): Monitoring stack with Prometheus/Grafana, Blocky DNS, Nginx reverse proxy
- **All machines**: Docker containerization platform available

## Nix Code Style

Never repeat module paths. Use nested attribute sets when there are multiple attributes under the same path. Use single-line format when there's only one attribute:

```nix
# Bad - repeated module references
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

# Good - nested when multiple attributes
boot.loader = {
  systemd-boot.enable = true;
  efi.canTouchEfiVariables = true;
};

# Good - single line when only one attribute
networking.hostName = "myhost";
```

## Development Environment

Integrated toolchain includes:
- Modern CLI tools: eza, fd, ripgrep, zoxide, atuin, direnv
- Language support: Node.js, Python, Lua, Deno, Gleam, Terraform  
- Editor: Neovim with LSP support
- Terminal: Alacritty with custom theming
- Shell: Zsh with extensive git workflow functions