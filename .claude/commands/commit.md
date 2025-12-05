---
argument-hint: [instruction]
allowed-tools: Bash(git add:*)
---

instructions: commit "$ARGUMENTS"

inspect the git working state and create a commit with an appropriate message.

if there are multiple unrelated changes in the working directory, use `git add --patch` to stage only the changes that belong together in a single logical commit.

commit message MUST adhere to the following rules:
- commit messages SHOULD be a single high-level summary line MOST of the time
- NEVER use "and" in title. think abstractly. what is the common theme of the diff?
- if there's something PARTICULARLY NOTEWORTHY, you are allowed to add one extra line in the body
- use lowercase for ALL text except proper names
- NEVER include mentions of claude in git messages
- do NOT add any footers or signatures to git messages
- do NOT follow "conventional commits" with type prefix
