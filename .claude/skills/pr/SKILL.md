---
allowed-tools: Bash(git switch --create:*), Bash(git push:*), Bash(gh:*)
---

determine the primary branch using `gh repo view --json defaultBranchRef`.

fetch the primary branch from the remote and rebase the current branch onto it, so the PR is not marked "out of date" on github. if the rebase conflicts, stop and report the conflict instead of forcing through.

if on the primary branch, create and push a new branch with no name prefix.
if on a non-primary branch, skip push if the remote is already up to date.

before creating the PR, re-read the repo's CLAUDE.md in full and check every file in the diff against its conventions. fix violations first, so the PR does not ship them.

create a PR targeting the primary branch using `gh pr create`.

title and description follow the pull request preferences in `~/.claude/pr-preferences.md`.
