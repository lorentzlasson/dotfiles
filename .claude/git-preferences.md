## Git command preferences

- NEVER use `git checkout` - ALWAYS use `git switch` for branches and `git restore` for files
- `git switch` for switching branches: `git switch <branch>` or `git switch -c <new-branch>`
- `git restore` for restoring files: `git restore <file>` or `git restore --staged <file>`

## Git commit message rules

- NEVER use "and" in subject line - think abstractly about the common theme of the diff
- commit messages SHOULD be a single high-level subject line MOST of the time
- if there's something PARTICULARLY NOTEWORTHY, you are allowed to add one extra line in the body
- use lowercase for ALL text - INCLUDING BODY
- DO NOT follow "conventional commits" with type prefix
- focus on WHY, not WHAT
