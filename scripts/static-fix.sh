#!/usr/bin/env bash

set -euo pipefail

find nix/ -name "*.nix" -exec nixfmt {} +
statix fix nix/
deadnix --edit --exclude nix/*/hardware-configuration.nix nix/
shfmt --indent 2 --write .config/shell/*.sh .zshrc
stylua .config/nvim/
