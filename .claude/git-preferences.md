## Git command preferences

- `git checkout` is BANNED. do NOT use it. EVER. not for branches, not for files, not for anything.
- switching branches: `git switch <branch>` or `git switch --create <new-branch>`
- restoring files: `git restore <file>` or `git restore --staged <file>`
- if you catch yourself about to type `checkout`, STOP and use `switch` or `restore` instead
- NEVER use `-C` flag - run git commands from the project root

## Git commit message rules

- commit messages must be in English

- NEVER use "and" in subject line - think abstractly about the common theme of the diff
- commit messages SHOULD be a single high-level subject line MOST of the time
- if there's something PARTICULARLY NOTEWORTHY, you are allowed to add one extra line in the body
- use lowercase for ALL text - INCLUDING BODY
- DO NOT follow "conventional commits" with type prefix
- focus on WHY, not WHAT
- prefer describing behavior change over implementation detail (e.g. "restow on sync" not "add restow to sync recipe")
