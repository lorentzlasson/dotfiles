---
argument-hint: [kebab-case-name]
allowed-tools: ExitPlanMode, mcp__linear__save_issue, mcp__linear__list_teams, mcp__linear__list_projects, Bash(rm:*), Bash(ls:*)
description: "Process: 1) shift+tab to plan 2) /save-plan (auto-exits plan mode)"
disable-model-invocation: true
---


1. Exit plan mode first (use ExitPlanMode tool)
2. List `~/.claude/plans/` sorted by modification time (newest first)
3. Read the newest plan file
4. If "$ARGUMENTS" is provided, use it as the issue title. Otherwise derive a short title from the plan content.
5. File the plan as a Linear issue on the team and project that owns the affected area — backend/content work goes on **Product** / **Content Platform**. The plan body becomes the issue description. Name any repo and branch explicitly, since the issue outlives the worktree.
6. Delete the local plan file and report the issue URL.

Never save the plan as a markdown file in a repo.
