#!/usr/bin/env bash

set -euo pipefail

find nix/ -name "*.nix" -exec nixfmt --check {} +
statix check nix/
deadnix --fail --exclude nix/*/hardware-configuration.nix nix/
shellcheck --shell=bash --exclude=SC1090,SC1091,SC2034,SC2086,SC2155 nix/**/*.sh .config/shell/*.sh .zshrc
shfmt --indent 2 --diff .config/shell/*.sh .zshrc
stylua --check .config/nvim/
