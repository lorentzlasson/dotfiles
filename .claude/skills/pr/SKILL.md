---
allowed-tools: Bash(git switch --create:*), Bash(git push:*), Bash(gh:*)
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
- default to NO body. the title carries the change; a body is the exception, not the norm.
- add a body ONLY for information absent from both title and diff — perf numbers, an invariant the change preserves, a non-obvious why, a link to an issue. never restate or summarize the diff.
- when a body is warranted, keep it to 1-3 short bullets, max ~3 lines total. if it runs longer, it's saying too much — cut it.
- when the change alters flow of logic or an algorithm such that a flowchart would clarify it, append a mermaid flowchart as the last element of the body inside a `<details>` tag.
