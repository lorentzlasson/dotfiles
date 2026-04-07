---
description: "Run session start checks: verify @path imports expanded, and other sanity checks."
user_invocable: true
allowed-tools: Bash(bash ~/dotfiles/.claude/scripts/check-context-imports.sh:*)
---

Run `bash ~/dotfiles/.claude/scripts/check-context-imports.sh` with the project root as argument. It outputs lines in the format:

    @reference|/resolved/path|exists_on_disk

For each file listed where `exists=true`: check whether that file's contents are actually present in your loaded context. If the contents are missing from context, the `@` import was NOT expanded — report it.

For each file where `exists=false`: report that the referenced file doesn't exist on disk.

Keep the output short.
