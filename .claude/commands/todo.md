---
argument-hint: <description>
allowed-tools: Bash(git add:*), Bash(git commit:*)
description: Create a structured todo document for complex features or investigations
---

Create a planning document at `todo/{description-in-kebab-case}.md`.

"$ARGUMENTS" contains the feature/investigation description. Use it to generate the filename in kebab-case and structure the document content.

Structure the document with a preliminary implementation plan.

If there is a `just static-fix` command available, run it after to ensure corrent formatting.

Commit the document immediately after creation respecting the users git preferences. Follow git preferences strictly. Use "plan" as leading verb.
