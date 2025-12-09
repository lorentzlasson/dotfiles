---
argument-hint: [instruction]
allowed-tools: Bash(git add:*)
---

instructions: commit "$ARGUMENTS"

inspect the git working state and create a commit with an appropriate message.

if there are multiple unrelated changes in the working directory, use `git add --patch` to stage only the changes that belong together in a single logical commit.

commit message MUST adhere to the following rules:
- IMPORTANT! NEVER use "and" in subject line. think abstractly. what is the common theme of the diff?
- commit messages SHOULD be a single high-level subject line MOST of the time
- if there's something PARTICULARLY NOTEWORTHY, you are allowed to add one extra line in the body
- use lowercase for ALL text except proper names
- NEVER include mentions of claude in git messages
- do NOT add any footers or signatures to git messages
- do NOT follow "conventional commits" with type prefix
- DO NOT use `git -C <DIR>`. just remain in root and use `git` normally
