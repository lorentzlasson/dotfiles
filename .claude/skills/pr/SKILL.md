---
allowed-tools: Bash(git:*), Bash(gh:*)
disable-model-invocation: true
---

determine the primary branch using `gh repo view --json defaultBranchRef`.

if on the primary branch, create and push a new branch with no name prefix.
if on a non-primary branch, skip push if the remote is already up to date.

create a PR targeting the primary branch using `gh pr create`.

- use lowercase for all text
- high-level descriptive title (max ~72 chars)
- no headers in description
- no test plan section
- description focuses on WHY, not WHAT
- use bullet lists when appropriate
