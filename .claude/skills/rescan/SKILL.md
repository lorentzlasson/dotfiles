---
---

CRITICAL: Do NOT assume the existing CLAUDE.md is accurate. ALWAYS verify against actual codebase.

Use the Task tool with subagent_type=Explore to thoroughly analyze the codebase structure, key files, and configuration.

The exploration MUST:
1. Verify all documented directories and files actually exist
2. Find files/directories that exist but aren't documented
3. Check version numbers and counts match reality
4. Validate all file paths are correct
5. Identify any contradictions between docs and code

After exploration, compare findings to existing CLAUDE.md and update it with:
- repository overview
- architecture details
- common commands/workflows
- important files and their purposes
- any other relevant developer context

Keep it concise and actionable. Focus on what developers need to know to work effectively in this codebase.

NEVER say "documentation looks good" without actually exploring the codebase first.
