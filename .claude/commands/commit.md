---
argument-hint: [instruction]
allowed-tools: Bash(git add:*)
---

$ARGUMENTS

inspect the git working state and create a commit with an appropriate message.

if there are multiple unrelated changes in the working directory, use `git add --patch` to stage only the changes that belong together in a single logical commit.

follow git preferences strictly

never capitalize words except proper names
