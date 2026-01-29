#!/usr/bin/env bash

claude mcp add playwright \
  --scope user \
  -- \
  deno run \
    --allow-all \
    npm:@playwright/mcp@latest \
    --config ~/.claude/playwright-mcp-config.json
