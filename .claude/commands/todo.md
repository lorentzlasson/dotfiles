---
argument-hint: <description>
allowed-tools: Bash(git add:*), Bash(git commit:*)
description: Create a structured todo document for complex features or investigations
---

Create a planning document at `todo/{description-in-kebab-case}.md`.

Instructions: "$ARGUMENTS" 

Use these to generate the filename in kebab-case and structure the document content. If no instructions are given, use any ongoing discussion/context as best you can.

Structure the document with a preliminary implementation plan.

If there is a `just static-fix` command available, run it after to ensure corrent formatting.

Commit the document immediately after creation:
@.claude/commands/commit.md
