# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive dotfiles repository managing both NixOS system configurations and user application configurations. It uses a hybrid approach with NixOS flakes for system management and GNU Stow for user dotfiles.

## Architecture

### NixOS Configuration Structure
- `nix/flake.nix` - Main configuration defining 4 machines: xps15, xps13, asus (desktops) and nuc (server)
- `nix/configuration.nix` + `nix/packages.nix` - Base config and packages for all machines (Docker, basic tools)
- `nix/pc/` - Desktop base config (GNOME, GUI apps); `nvidia.nix` and `steam.nix` are opt-in per machine
- Machine configs (`nix/{machine}/`) inherit from base + add hostname and hardware-configuration.nix
- `nix/nuc/configuration.nix` - Server config (Nginx, Grafana, Prometheus, Blocky DNS), imports base directly

### Key Directories
- `nix/{machine}/` - Machine-specific configs (hostname, hardware)
- `nix/pc/` - Desktop base config
- `.config/` - User application configs managed via Stow

## Common Commands

All operations go through `just` (see `justfile` in repo root, `just --list`). Never run raw `sudo nixos-rebuild`.

### Dotfiles Setup
```bash
cd ~
git clone https://github.com/lorentzlasson/dotfiles
rm -rf ~/.config && mkdir -p ~/.config
cd dotfiles
just stow
```

## Important Files

- `nix/flake.nix` - System entry point, all machine definitions
- `nix/pc/configuration.nix` - Desktop configuration template
- `nix/nuc/configuration.nix` - Server configuration
- `.zshrc` - Shell configuration with vi-mode and custom prompt
- `.config/shell/{aliases,functions}.sh` - Shell productivity enhancements
- `.config/nvim/init.lua` - Neovim configuration entry point
- `.gitconfig` - Git configuration with 50+ custom aliases

## Machine Configurations

- **Desktop machines** (xps15, xps13, asus): Full development environment with GNOME; xps15 and asus add Steam and Nvidia
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

## Workflows

- Use `just` commands for common operations (see `justfile` in repo root)
- NixOS rebuild: `just nix-rebuild` (not raw `sudo nixos-rebuild` commands)
- NixOS update: `just nix-update`
- Deploy to another machine over ssh: `just nix-deploy nuc`
- Stow dotfiles: `just stow` / `just restow`
- Hardware config sync: `just hardware-sync`
- Full update: `just update-all`
- Lint and format: `just static-qa` / `just static-fix`

## Development Environment

Integrated toolchain includes:
- Modern CLI tools: eza, fd, ripgrep, zoxide, atuin, direnv
- Language support: Python, Lua, Deno, Gleam
- Editor: Neovim with LSP support
- Terminal: Ghostty with custom theming
- Shell: Zsh with extensive git workflow functions
