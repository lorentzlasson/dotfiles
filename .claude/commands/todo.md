---
argument-hint: <description>
allowed-tools: Bash(git add:*), Bash(git commit:*)
description: Create a structured todo document for complex features or investigations
---

Create a planning document at `todo/{description-in-kebab-case}.md`.

Structure the document with these sections:

1. Current State
2. Objective
3. Implementation Plan
4. Technical Details
5. Testing Strategy
6. Next Steps

Include actionable steps with code examples and specific file paths.

Commit the document immediately after creation respecting the users git
preferences.

"$ARGUMENTS" contains the feature/investigation description. Use it to generate
the filename in kebab-case and structure the document content.
