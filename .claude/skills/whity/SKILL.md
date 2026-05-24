---
argument-hint: [optional focus]
---

"what have i told you?" — stop, reflect deeper on established instructions, and reevaluate the currently initiated action.

1. **Re-read instructions:**
   - `~/.claude/CLAUDE.md` and any `@`-imported files (e.g. `git-preferences.md`)
   - Any project-level `CLAUDE.md`
   - Re-scan recent conversation for user-specific guidance, corrections, or pushback

2. **Identify the in-flight action:** what were you about to do, or what did you just initiate?

3. **Check it against instructions.** Common slips:
   - write action in response to a question (`?`)
   - executing an instruction ending in `??` instead of advising
   - using `cd`, `git checkout`, or `-C` flags
   - punting work back to the user
   - drive-by cleanup / feature creep inside a focused task
   - flip-flopping under disagreement instead of defending sound reasoning
   - adding comments unprompted
   - silent compliance with mediocre code
   - estimating in human time
   - asking permission to search instead of just searching
   - presenting options without an explicit recommendation

4. **Report:**
   - what was in flight
   - rule violations (cite the rule)
   - corrected approach
   - wait for user confirmation before resuming

If `$ARGUMENTS` is provided, focus the audit there.
