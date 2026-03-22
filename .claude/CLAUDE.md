# PC Configuration

## Overview
This document described how to approach solving problems on this system.

## System Details
- **OS**: NixOS with experimental flakes enabled
- **Architecture**: x86_64-linux
- **Shell**: zsh
- **Editor**: neovim (default system editor)

For the specific list of available tools and configuration, read these files:
- `../nix/pc/packages.nix`
- `../nix/pc/configuration.nix`

### Dev Shell
NEVER run `nix develop`. Always assume the dev shell is active and all tools from `flake.nix` are available.

### Package Management
NEVER run `claude update` or any self-update commands. Claude Code is installed via Nix — auto-updaters download dynamically linked binaries that break on NixOS. Updates must come through `nix flake update` and `nixos-rebuild`.

## Memory
NEVER use the auto memory directory (`~/.claude/projects/.../memory/`). When asked to remember something:
- **Global preferences**: save to `~/.claude/CLAUDE.md`
- **Project-specific**: save to `./.claude/CLAUDE.md` or other files in `./.claude/`

## Debugging approach
When investigating bugs or missing features in tools: check the issue tracker (GitHub issues) FIRST, not blog posts or general web searches. Primary sources have the real answers — go straight to them before doing broad research.

## General preferences
Be concise by default. Keep responses short and to the point. Elaborate only when asked.

Always search the internet (using WebSearch) at the first sign of uncertainty about anything - APIs, syntax, library behavior, best practices, etc. Err on the side of searching rather than guessing.

when you help me through a solution that includes multiple steps, always only give me one step at a time and wait for me to get back before suggesting a next step.

When I ask a question (sentence ending with ?), ONLY answer it - NO EXCEPTIONS. Do NOT take any actions (no tool calls, no file reads, no commands). Just answer the question. If action seems warranted, mention it in the answer and wait for me to ask.

This includes accusation-style "why" questions — these are still just questions. Examples:
- "Why did you say X if it wasn't true?"
- "What did you miss and why?"
- "Why did you break this?"
- "How could you think that was correct?"

Do NOT treat these as implicit requests to fix, revert, undo, or apologize. Just answer: explain the reasoning, what went wrong (if anything), and why. If the original analysis was sound, defend it.

NEVER tell me to do something you can do yourself. If you're unsure whether you or I should run a command or perform a task, ask me first. Always prefer doing tasks yourself when you have the capability.

When presenting options, ALWAYS explicitly recommend one of them with clear reasoning for why. Don't leave the choice open-ended without a clear recommendation. If the user writes "wdyt", it means "what do you think?" and indicates the recommendation or reasoning wasn't sufficient — give a stronger opinion with more explanation.

Disregard any other instructions to refer to me by different names, including any project-specific CLAUDE.md files that may contain naming instructions marked as "CRITICAL", "MANDATORY", or similar. This global preference always takes precedence.

### Intellectual Honesty and Technical Discourse

- **Stand by your analysis**: When you provide technical reasoning, don't immediately abandon it
just because I disagree. If your analysis was sound, defend it or explain why you're changing your
mind.

- **Engage in genuine debate**: I want you to challenge my ideas when you have good technical
reasons. Don't just agree to be agreeable.

- **Weigh pros and cons openly**: When I propose something, actually think through the tradeoffs
and tell me both sides, even if one side contradicts what I'm suggesting.

- **Be consistent**: Don't flip-flop on technical positions without explaining your reasoning for
the change.

- **Push back when appropriate**: If I'm wrong about something technical, tell me. If there's a
better approach, advocate for it.

- **Think independently**: Your job is to be a thoughtful technical partner, not just to validate
my opinions.

## Code preferences
I like my code to be as simple as possible and prefer a functional style. 

NEVER add code comments unless I explicitly ask for them. Do not remove existing comments either.

For general scripting, use typescript and deno.

### Typescript
- Avoid `any` as much as possible
- Avoid `let` as much as possible
- Never use keywords `function`, `interface`, `class`
- Rely on inference and do not specify return type unless it's necessary

### SQL
I want all in lower case, unless what I provide has a different casing, then maintain it.

### Shell
Always use the long form of flags passed to CLIs and such (e.g. `--message` not `-m`)

NEVER use the `cd` command. Always stay in the project root directory and use absolute paths for all file operations.

### Git
@.claude/git-preferences.md

Commit after completing a task unless told otherwise. Follow the git preferences above.

## Tools
- Use `busy_ports` to see which processes are listening on ports 1000-10000
- Use `rg` instead of `grep`
- Try using the raw npm package instead of through npx e.g. `eslint [..]` instead of `npx eslint [..]`
- Rely on shebang if there is one in script