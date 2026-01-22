---
argument-hint: [instruction]
allowed-tools: Bash(git add:*)
disable-model-invocation: true
---

instructions: commit "$ARGUMENTS"

inspect the git working state and create a commit with an appropriate message.

IMPORTANT: if there is a staged diff (check with `git diff --cached`), ONLY commit the staged files. DO NOT add any unstaged changes. if there is NO staged diff, then proceed to add relevant files as usual.

if there are multiple unrelated changes in the working directory and no staged diff, use `git add --patch` to stage only the changes that belong together in a single logical commit.

@~/.claude/git-preferences.md

- DO NOT use `git -C <DIR>`. just remain in root and use `git` normally
