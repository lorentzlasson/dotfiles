#!/usr/bin/env bash
set -euo pipefail

before=$(git rev-parse HEAD)
git pull
after=$(git rev-parse HEAD)

if [ "$before" != "$after" ]; then
  echo ""
  echo "Changes pulled:"
  git log --oneline "$before..$after"
  echo ""
  git diff --stat "$before..$after"
  echo ""
  read -p "Continue with restow and push? [Y/n] " response
  if [[ "$response" =~ ^[Nn] ]]; then
    echo "Aborted."
    exit 1
  fi
fi

stow --restow .
git push
