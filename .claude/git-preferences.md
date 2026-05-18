## Git workflow expectations

- I will regularly modify git history/state out-of-band (reset, rebase, amend, branch, switch). Do NOT treat unexpected git state as a problem to investigate or undo. Re-read `git status`/`git log` fresh instead of relying on prior snapshots, and assume any change you didn't make was intentional.

## Git command preferences

- `git checkout` is BANNED. do NOT use it. EVER. not for branches, not for files, not for anything.
- switching branches: `git switch <branch>` or `git switch --create <new-branch>`
- restoring files: `git restore <file>` or `git restore --staged <file>`
- if you catch yourself about to type `checkout`, STOP and use `switch` or `restore` instead
- NEVER use `-C` flag - run git commands from the project root

## Git commit message rules

- commit messages must be in English

- NEVER use "and" in subject line - think abstractly about the common theme of the diff
- subject line: short "what" description - a single high-level summary of the change
- body: include a "why" only when it adds something not obvious from the subject/diff; otherwise omit entirely
- most commits should be subject-only - only add a body when there's a genuinely useful "why"
- use lowercase for ALL text - INCLUDING BODY
- DO NOT follow "conventional commits" with type prefix
- prefer describing behavior change over implementation detail (e.g. "restow on sync" not "add restow to sync recipe")
