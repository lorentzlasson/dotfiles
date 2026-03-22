## Playwright MCP Chrome Launch Failure

Playwright MCP fails to launch Chrome because an existing Chrome process is using the same user data directory.

### Error

```
browserType.launchPersistentContext: Failed to launch the browser process.
[pid=...][out] Opening in existing browser session.
[pid=...] <process did exit: exitCode=0, signal=null>
```

### Cause

Playwright tries to launch Chrome with `--user-data-dir=/home/lorentz/.cache/ms-playwright/mcp-chrome-4337afd`. If another Chrome instance already uses that directory, Chrome opens a tab in the existing session instead of launching a new process. Playwright sees the process exit immediately and reports a failure.

### Reproduction

1. Have Chrome running (any instance using the same user data dir)
2. Invoke any Playwright MCP browser tool (e.g. `browser_navigate`)

### Things tried that didn't help

- `mcp__playwright__browser_close` — returns "No open tabs" since Playwright never connected
- Removing `SingletonLock` file from the user data dir — Chrome still attaches to existing session

### Likely fix

Either:
- Close all Chrome windows before using Playwright MCP
- Configure Playwright MCP to use a different/fresh user data dir so it doesn't collide with regular Chrome usage
