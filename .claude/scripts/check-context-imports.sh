#!/usr/bin/env bash

project_root="${1:-.}"
global_claude="$HOME/.claude/CLAUDE.md"
project_claude="$project_root/CLAUDE.md"
dot_claude="$project_root/.claude/CLAUDE.md"

extract_refs() {
    local file="$1"
    local dir
    dir="$(dirname "$(readlink -f "$file")")"
    grep -oP '(?<![\[`\w])@(?:~?[./][\w./_~-]+|[\w][\w._-]*\.[\w]+)' "$file" 2>/dev/null | while read -r ref; do
        local path="${ref#@}"
        path="${path/#\~/$HOME}"
        if [[ "$path" != /* ]]; then
            path="$dir/$path"
        fi
        path="$(readlink -f "$path" 2>/dev/null || echo "$path")"
        local exists="false"
        [[ -f "$path" ]] && exists="true"
        echo "$ref|$path|$exists"
    done
    return 0
}

echo "=== files that should be loaded in context ==="

for f in "$global_claude" "$project_claude" "$dot_claude"; do
    [[ -f "$f" ]] && extract_refs "$f"
done

for skill in "$project_root/.claude/skills"/*/SKILL.md; do
    [[ -f "$skill" ]] && extract_refs "$skill"
done
