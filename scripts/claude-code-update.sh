#!/usr/bin/env bash
set -euo pipefail

cd ~/dotfiles

FLAKE=path:$HOME/dotfiles/nix

ver() {
  nix eval --raw "github:ryoppippi/claude-code-overlay/$(jq --raw-output '.nodes."claude-code-overlay".locked.rev' ~/dotfiles/nix/flake.lock)#packages.x86_64-linux.claude.version"
}

OLD=$(ver)
sudo nix flake update claude-code-overlay --flake "$FLAKE"
sudo nixos-rebuild switch --flake "$FLAKE"
NEW=$(ver)

if git diff --quiet nix/flake.lock; then
  echo "already at v$OLD"
  exit 0
fi

COMPARE="https://github.com/anthropics/claude-code/compare/v$OLD...v$NEW"

DELTA=$(curl --silent --fail --location https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md \
  | awk -v new="## $NEW" -v old="## $OLD" '$0 == old { exit } $0 == new { p = 1 } p' \
  | grep --invert-match --ignore-case '^- \(fixed\|bug fixes and reliability\)' \
  || true)

HIGHLIGHTS=""
if [[ -n "$DELTA" ]]; then
  HIGHLIGHTS=$(claude --print --model sonnet <<PROMPT || true
below is the claude code changelog delta from v$OLD to v$NEW.

write at most 8 bullets covering only things that change how a daily cli user works: new settings, env vars, slash commands, keybindings, tools, or changed default behavior. skip anything platform-specific i don't use (bedrock, vertex, foundry, windows, vscode, jetbrains, gitlab, enterprise/admin, self-hosted runners). skip pure bug fixes and internal improvements.

format: one bullet per line, starting with "- ", all lowercase, no headers, no preamble, no closing remarks. name the exact setting/command/env var in backticks. if nothing qualifies, output nothing at all.

$DELTA
PROMPT
)
fi

BODY="v$OLD -> v$NEW"
if [[ -n "$HIGHLIGHTS" ]]; then BODY="$BODY

$HIGHLIGHTS"; fi
BODY="$BODY

$COMPARE"

git commit --quiet nix/flake.lock --message "update claude code" --message "$BODY"

printf '\n%s\n' "$BODY"
