---
description: "Set up a repo with the standard .envrc + flake.nix dev environment (direnv-loaded Nix dev shell), matching the convention used across ~/dev. Use when asked to set up, add, or fix a repo's dev environment / devshell / direnv / flake."
user_invocable: true
argument-hint: "[path to repo, defaults to cwd]"
---

Copy the two files in `~/dotfiles/.claude/skills/devenv/template/` into the target repo, then adapt `buildInputs` to the project's actual stack. Everything else is invariant — don't redesign it per repo.

## Workflow

1. **Detect the stack** before writing anything — look for `deno.json`, `package.json`, `pyproject.toml`, `*.tf`, `Cargo.toml`, migrations, a `justfile`. That determines `buildInputs` and nothing else.
2. **Copy the template**, then replace the `buildInputs` list. Keep `just` if the repo has (or should have) a `justfile`.
3. **`git add --intent-to-add .envrc flake.nix`** so `nix flake` sees them — flakes ignore untracked files and will fail with a confusing "path does not exist" otherwise.
4. **`direnv allow`**, confirm the shell builds, and commit `flake.lock` alongside.
5. **Gitignore `.direnv/`** if it isn't already.

## Invariants

These are the whole point of having a convention. Don't deviate without saying why.

- **`.env` loads before `.env.local`.** direnv is last-wins, so the gitignored per-machine file must come last or it silently never overrides. Getting this backwards is the most common bug in these repos.
- **Pin nix-direnv to the version in the template.** It's inert on NixOS, which already provides nix-direnv system-wide, so it exists purely for collaborators on other platforms. When bumping it, bump every repo — a drifted pin means teammates get different behavior for no reason.
- **`flake-utils.lib.eachDefaultSystem`**, not hand-rolled system lists. macOS collaborators are the reason.
- **nixpkgs tracks `nixos-unstable`**, pinned by `flake.lock`. Refresh with `nix flake update` when you're already in the repo; don't chase a shared pin across repos.
- **Secrets never load by default.** A `.env.secrets` holding production credentials must be sourced explicitly by the scripts that need it, never via `dotenv_if_exists` — otherwise every local dev process runs with live prod credentials in its environment.

## Gotchas

- **`mkShell` with `//` needs parens.** `mkShell ({ ... } // lib.optionalAttrs cond { ... })` — without the parens the merge happens on the derivation after the fact and env vars are silently dropped.
- **Dynamically-linked binaries** (Playwright's chromium, prebuilt node binaries) need `LD_LIBRARY_PATH = lib.makeLibraryPath [ stdenv.cc.cc.lib zlib ]` on Linux, guarded with `lib.optionalAttrs (!pkgs.stdenv.isDarwin)`.
- **Proprietary packages** need `config.allowUnfree = true` on the `import nixpkgs`, not an overlay.

## Multi-worktree repos

If the repo runs a full local stack (server + db + process-compose) and you use git worktrees on it, port collisions are the problem. `~/dev/boilerplate/scripts/envrc-worktree.sh` is the working reference: it assigns each worktree a stable numeric offset and shifts every port by it. Copy and adapt the port list — it's inherently per-project, so there's no shared version to link against.
