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

## General preferences
when you help me through a solution that includes multiple steps, always only give me one step at a time and wait for me to get back before suggesting a next step.

If I ask questions, ALWAYS answer questions before starting to execute. 

## Code preferences
I like my code to be as simple as possible and prefer a functional style. 

I dont want comments describing the code, unless the code is very complex (which it rarely should be).

For general scripting, use typescript and deno.

### Typescript
- Avoid `any` as much as possible
- Avoid `let` as much as possible
- Never use keywords `function`, `interface`, `class`
- Rely on inference and do not specify return type unless it's necessary

### SQL
I want all in lower case, unless what I provide has a different casing, then maintain it.

### Shell
Always use the long form of flags passed to CLIs and such

### README files

When writing README files:

Focus on workflows, not documentation
- Answer "How do I actually use this?" not "What is this?"
- Lead with the most common use case
- Include practical, real-world examples with actual commands

Keep it concise and actionable
- Use simple titles
- Cut redundant sections (installation, integration, architecture explanations)
- Use numbered steps for workflows
- Highlight critical info with GitHub alerts (> [!IMPORTANT])

Avoid maintenance nightmares
- Never duplicate code in README - use relative links instead
- Don't mirror API documentation
- Don't explain what the code does - explain how to use it
- Focus on the interface, not implementation details

Structure for libraries/tools
1. Brief description of purpose
2. Key workflow/usage steps
3. Important caveats or warnings
4. How sync/deployment works (if applicable)

## Tools
- Use `rg` instead of `grep`
- Try using the raw npm package instead of through npx e.g. `eslint [..]` instead of `npx eslint [..]`
- Rely on shebang if there is one in script