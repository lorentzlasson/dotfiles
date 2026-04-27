---
argument-hint: [<github-pr-url>] (optional — defaults to current branch vs base)
allowed-tools: Bash(gh:*), Bash(git diff:*), Bash(git log:*), Bash(git rev-parse:*), Bash(git merge-base:*), Read
disable-model-invocation: true
---

mimic github copilot's PR reviewer: a fast, narrow, pattern-class sweep over the diff.

do NOT post anything to github. output the report locally only.
do NOT make edits. do NOT run tests. this is a read-only review pass.

# scope

review ONLY what's in the diff. do NOT explore the broader codebase. do NOT propose architectural changes. open full files only when a hunk is unintelligible without surrounding context.

# input

if a github PR url is provided, fetch via:
- `gh pr diff <number> --repo <owner>/<repo>` for the unified diff
- `gh pr view <number> --repo <owner>/<repo> --json title,body,files,baseRefName,headRefName` for metadata

if no argument, diff the current branch against its merge-base with the default branch:
- resolve default branch via `gh repo view --json defaultBranchRef`
- `git merge-base HEAD <default>` → base
- `git diff <base>...HEAD`

# review pass

for each changed hunk, do a fresh-eyes pattern-check. flag any of:

- numeric coercion: `parseInt`/`parseFloat`/`Number` on possibly-empty input → NaN written to state
- sentinel fallbacks: `?? 0`, `?? ""`, `?? -1` etc. producing invalid downstream data instead of failing loudly
- type-bypassing casts: `as T`, `as unknown as T`, `{} as T`; spread of `{} as T` in tests that hides newly-required fields
- i18n inconsistency: hardcoded user-facing strings adjacent to `t(...)` siblings
- empty-truthy bugs: treating `{}` / `[]` / `{ x: "" }` as a non-empty answer in validation
- ungated mutation: `sort`/`splice`/`reverse` on inputs, direct mutation of props/state
- async leaks: `useEffect` without cleanup, missing `await`, unhandled rejections
- dead spreads / dead code: spreads over empty objects, unused imports, unreachable branches
- off-by-one in ranges, slices, indices
- error swallowing: `catch (e) {}`, ignored throws
- missing required validation: required fields never gated by truthy check
- broken hook deps: `useEffect`/`useMemo`/`useCallback` deps missing read values or carrying unstable references
- magic numbers / strings without named constants when nearby code uses constants
- secret/PII exposure in new logs

skip stylistic nits (formatting, naming) unless they cross into ambiguity or bugs.

# output format

1. **overview** — 2-3 sentence summary of what the diff does
2. **per-file table** — one short line per changed file
3. **findings** — 0-7 entries, each:
   - `path/to/file.ts:LINE`
   - one sentence: what's wrong
   - one sentence: recommended fix or counter-question

prefer fewer sharp findings over many low-confidence ones. if nothing suspicious, say so plainly.
