---
argument-hint: [kebab-case-name]
allowed-tools: ExitPlanMode, Bash(mv:*), Bash(mkdir:*), Bash(ls:*)
description: "Process: 1) shift+tab to plan 2) /save-plan (auto-exits plan mode)"
disable-model-invocation: true
---


1. Exit plan mode first (use ExitPlanMode tool)
2. List `~/.claude/plans/` sorted by modification time (newest first)
3. Read the newest plan file
4. If "$ARGUMENTS" is provided, use it as the filename. Otherwise derive a kebab-case filename from the plan content.
5. Move the plan to `./todo/{name}.md`
