---
description: "Record a video/screencast of browser or app behavior (animations, flows, transitions) using Playwright's native recordVideo. Use when asked to record, capture, or screencast a video of something happening in the browser. NOT for static screenshots."
user_invocable: true
---

Do NOT take screenshots and stitch them — that loses animations. Use the harness in this skill directory (`~/dotfiles/.claude/skills/record-video/`): it bakes in the playwright-core path resolution, viewport, `recordVideo`, `try/finally` flush, and webm→mp4 conversion.

## Workflow

1. **Write a flow file** in the target project — copy `~/dotfiles/.claude/skills/record-video/flow.example.ts`. It exports `config` (baseURL, viewport, and either a scripted `auth` or a `storageState` path) and `clips` (one async fn per video), typed by `Flow` from the skill's `types.ts`.
2. **Run it** from the project root: `~/dotfiles/.claude/skills/record-video/record-video.ts --flow flow.ts` (the harness is a self-contained Deno shebang script). Each clip lands at `out/<name>.mp4`. Flags: `--clip <name>` to re-record just one while iterating selectors, `--headed` to watch.
3. **Hand the user the mp4 path** to drag-drop into the PR — `gh` doesn't take video cleanly.

## Auth

Prefer scripted `auth` over capturing session state: it logs in headless, grabs `storageState` via the native API (includes httpOnly cookies), and leaves no live-token file on disk. Only fall back to a captured `storageState.json` when login isn't scriptable — and delete it when done.

## Locator gotchas

These bite every time; the harness helpers encode the first three.

- **Use `fill(value)`, not `.type()`, for React-controlled inputs.** Per-keystroke `.type()` detaches the element handle when React re-renders on each change → mid-type timeout. `fill` is atomic and fires the input event React needs.
- **`:visible` on every locator** — the `v(sel)` helper appends it. SPAs keep multiple instances mounted and hide inactive ones with `display:none`; a bare `.first()` silently grabs a hidden offscreen instance.
- **Don't trust `getByLabel` with MUI fields** — many have a visible `<label>` with no `for`/`id` association. Use the `field(label)` helper (`.MuiFormControl-root:visible:has-text("<label>") input:visible`).
- **`sleep(ms)` between actions** so the video isn't a blur.

## ffmpeg

The ffmpeg symlink Playwright wants at `~/.cache/ms-playwright/ffmpeg-1011/ffmpeg-linux` is set up declaratively by `systemd.user.services.playwright-ffmpeg` in `~/dotfiles/nix/pc/configuration.nix`. If a fresh rebuild hasn't activated it yet: `systemctl --user start playwright-ffmpeg`.
