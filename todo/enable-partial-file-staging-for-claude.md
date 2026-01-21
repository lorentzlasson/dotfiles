# Enable Partial File Staging for Claude Code

## Goal
Enable Claude Code to make changes that can be split into multiple logical commits, allowing the user to stage and commit different concerns separately even when changes are in the same file.

## Problem Statement
Claude Code often makes multiple logical changes (e.g., bug fix + refactoring, or feature A + feature B) that should be separate commits. Currently, the user must manually use `git add --patch` after Claude makes all changes. This is tedious and error-prone.

The challenge: `git add -p` is interactive and cannot be reliably automated by Claude Code.

## Research Findings

### Community Solutions
Research reveals several existing approaches to this problem:

1. **llm-git** (https://github.com/can1357/llm-git) - Has "Compose mode" that splits large staged changes into multiple logical atomic commits using Claude/GPT APIs via `lgit --compose`

2. **commit-work skill** (https://claude-plugins.dev/skills/@jMerta/codex-skills/commit-work) - Claude Code skill that reviews/stages changes and splits into logical commits using criteria: feature vs refactor, backend vs frontend, formatting vs logic, tests vs prod code, dependency bumps vs behavior changes

3. **grepdiff workflow** - Validated community approach using patchutils:
   ```bash
   git diff --staged -U1 | grepdiff foo --invert-match --output-matching=hunk | git apply --cached -R
   ```

4. **expect automation** - Uses expect tool to automate `git add -p` responses based on pattern matching

### Key Community Insights
- Git's native partial staging is fundamentally interactive, making automation challenging
- grepdiff approach is the most battle-tested method for pattern-based non-interactive staging
- Most developers accept interactive flow; automation is a niche need
- Adjacent changes without unchanged lines between them cannot be auto-split by Git
- "Stacked diffs" pattern aligns with sequential commit workflow

## Implementation Plan

### 1. **Research and Choose Approach**
Evaluate the following options:

#### Option A: Pattern-Based Staging (grepdiff) ⭐ RECOMMENDED
- Install `patchutils` package (provides `grepdiff`)
- Claude annotates edits with markers: `# COMMIT:feature`, `# COMMIT:refactor`
- After all changes: `git diff | grepdiff --output-matching=hunk PATTERN | git apply --cached`
- Stage each logical group separately
- Clean up markers before final commit

**Pros:** Scriptable, precise control, works with existing git workflow, battle-tested by community
**Cons:** Code pollution during development, cleanup step required
**Evidence:** Validated by patchutils community, working examples in GitHub issues

#### Option B: Sequential Commit Workflow ⭐ SIMPLEST
- Claude plans changes upfront, grouped by logical concern
- Make change group 1 → stage → commit
- Make change group 2 → stage → commit
- Iterate until complete

**Pros:** Clean, simple, no temporary artifacts, aligns with "stacked diffs" pattern
**Cons:** Cannot see all changes together, more back-and-forth
**Evidence:** Used by llm-git's compose mode, aligns with commit-work skill approach

#### Option C: Metadata-Tracked Edits
- Claude internally tracks which logical group each edit belongs to
- Programmatically reconstruct separate patches per group
- Apply each patch to staging area independently

**Pros:** No code pollution, precise tracking
**Cons:** Complex implementation, requires extending Claude Code's internal state
**Evidence:** No community examples found; theoretical approach

#### Option D: Manual Diff Splitting
- Claude generates full diff
- Parse diff into hunks
- Programmatically split hunks into separate patch files
- Apply patches with `git apply --cached`

**Pros:** No external dependencies
**Cons:** Complex hunk parsing, fragile
**Evidence:** Community recommends grepdiff over manual parsing

#### Option E: Expect Automation
- Use expect tool to automate responses to `git add -p`
- Script responds with y/n based on pattern matching in hunks

**Pros:** Leverages Git's native interactive mode
**Cons:** Fragile, depends on git prompt format, less portable
**Evidence:** Discussed in blog posts but not widely adopted

### 2. **Prototype Chosen Approach**
- Implement proof-of-concept with test file
- Verify it handles edge cases (overlapping changes, whitespace, binary files)
- Test with real-world scenarios

### 3. **Integrate with /commit Command**
- Update `~/.claude/commands/commit.md` to support split-commit workflow
- Add detection: if markers present, use grepdiff workflow
- Add cleanup step to remove markers after staging

### 4. **Create Helper Scripts**
- `git-stage-pattern` - Wrapper around grepdiff workflow
- `git-cleanup-markers` - Remove COMMIT: markers from files
- Add to `~/.config/shell/functions.sh` or standalone scripts

### 5. **Update Documentation**
- Add workflow examples to `.claude/git-preferences.md`
- Document when/how to request split commits from Claude
- Add troubleshooting section

## Source Code Areas Affected

### System Configuration
- `nix/pc/packages.nix` - Add `patchutils` package (if choosing Option A)

### User Configuration
- `.config/shell/functions.sh` - Add helper functions for split-commit workflow
- `.claude/commands/commit.md` - Update commit logic to handle markers
- `.claude/git-preferences.md` - Document the new workflow

### Repository Documentation
- `CLAUDE.md` - Add section on requesting split commits from Claude

## Recommendation

**Best Hybrid Approach: Start with Option B (Sequential), with Option A (grepdiff) as fallback**

### Why This Hybrid?

1. **Option B for most cases** - Sequential workflow is cleanest and aligns with how commit-work skill and llm-git operate. No code pollution, no cleanup needed.

2. **Option A for complex cases** - When user explicitly needs to see all changes together before splitting, use grepdiff markers. This handles edge cases where understanding interactions between changes is critical.

### Recommended Marker Syntax (for Option A when needed)
- Use `@commit:<label>` format in comments
- Language-agnostic: works in `#`, `//`, `/**/` style comments
- Examples:
  - `# @commit:feature` (Python, shell, Ruby)
  - `// @commit:refactor` (JavaScript, TypeScript, C++, Rust)
  - `/* @commit:bugfix */` (CSS, C)

### Cleanup Strategy
- **Automatic cleanup** after successful commit
- Helper function: `git-cleanup-commit-markers` removes all `@commit:` markers
- Run automatically as part of commit workflow

### Multi-Language Handling
- Store marker patterns per language in config
- Auto-detect comment style from file extension
- Fallback: ask Claude to use appropriate comment syntax for each file

## Decision Points

Before proceeding, decide:
1. ~~Which approach to implement (A, B, C, or D)?~~ → **Hybrid: B as primary, A as fallback**
2. ~~What marker syntax to use?~~ → **`@commit:<label>` format**
3. ~~Should cleanup be automatic or manual?~~ → **Automatic cleanup**
4. ~~How to handle multi-language projects?~~ → **Auto-detect from file extension**
5. **NEW:** How should user trigger split-commit mode? (command flag, auto-detect, explicit request?)
6. **NEW:** Should we integrate llm-git or build custom solution?

## Success Criteria

- Claude can make 3+ distinct logical changes to a single file
- User can stage and commit each logical change separately
- Workflow feels natural and doesn't require excessive manual intervention
- No temporary artifacts left in committed code

## References

### Existing Tools
- llm-git: https://github.com/can1357/llm-git
- commit-work skill: https://claude-plugins.dev/skills/@jMerta/codex-skills/commit-work
- patchutils (grepdiff): https://github.com/twaugh/patchutils
- split-patch: https://github.com/aleclearmind/split-patch

### Documentation
- Fekir's Blog - Automate git interactive add: https://fekir.info/post/automate-git-interactive-add/
- Choly's Blog - Git programmatic staging: https://choly.ca/post/git-programmatic-staging/
- A practical guide to automating git workflows with Claude Code: https://www.eesel.ai/blog/git-workflows-claude-code
- patchutils grepdiff invert match issue: https://github.com/twaugh/patchutils/issues/36

### Related Concepts
- Git Stacked Diffs Made Easy: https://gitscripts.com/git-stacked-diffs
- Manually Editing Git Hunks: https://rietta.com/blog/git-patch-manual-split/
