---
argument-hint: <description>
description: Dump a todo item to a markdown file
---

Create a file at `todo/{description-in-kebab-case}.md`.

If "$ARGUMENTS" is provided:
- Use the arguments as the content
- Clean up typos and grammar, but do not expand or flesh out the content
- Derive a kebab-case filename from the content

If "$ARGUMENTS" is empty:
- Summarize the current conversation context as actionable todo instructions
- Derive a kebab-case filename from the summary

The file should be plain, concise instructions — not a plan, not an investigation, just what needs to be done.
