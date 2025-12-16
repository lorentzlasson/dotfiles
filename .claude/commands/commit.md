---
argument-hint: [instruction]
allowed-tools: Bash(git add:*)
---

instructions: commit "$ARGUMENTS"

inspect the git working state and create a commit with an appropriate message.

if there are multiple unrelated changes in the working directory, use `git add --patch` to stage only the changes that belong together in a single logical commit.

@~/.claude/git-preferences.md

- DO NOT use `git -C <DIR>`. just remain in root and use `git` normally
