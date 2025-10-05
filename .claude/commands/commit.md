---
argument-hint: [instruction]
allowed-tools: Bash(git add:*)
---

$ARGUMENTS

inspect the git working state and create a commit with an appropriate message.

CRITICAL: follow these practices:
- NEVER include mentions of claude in git messages (no "generated with claude code", no "co-authored-by: claude", no claude mentions whatsoever)
- do NOT add any footers or signatures to git messages
- use lowercase for all text except proper names
- use lowercase for commit titles, bullet points, and all git message text
