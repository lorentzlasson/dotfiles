---
argument-hint: [kebab-case-name]
allowed-tools: Bash(mv:*), Bash(mkdir:*), Bash(ls:*)
description: "Process: 1) shift+tab to plan 2) reject/abort to avoid implementation 3) /save-plan"
disable-model-invocation: true
---


1. List `~/.claude/plans/` sorted by modification time (newest first)
2. Read the newest plan file
3. If "$ARGUMENTS" is provided, use it as the filename. Otherwise derive a kebab-case filename from the plan content.
4. Move the plan to `./todo/{name}.md`
