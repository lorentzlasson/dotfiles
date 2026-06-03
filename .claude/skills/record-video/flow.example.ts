// Flow file for the record-video skill. Copy into the target project, fill in,
// then run from the project root:
//   ~/.claude/skills/record-video/record-video.ts --flow flow.ts
// Re-record one clip while iterating selectors: --clip review
// Watch it happen: --headed
//
// The Flow type import is type-only (erased at runtime); keep the absolute path
// so it resolves after you copy this file into another project.
import type { Flow } from "file:///home/lorentz/.claude/skills/record-video/types.ts";

export const config: Flow["config"] = {
  baseURL: "http://localhost:3000",
  viewport: { width: 1440, height: 810 },

  // Preferred: scripted login. Runs once in a non-recording context and
  // captures storageState via the native API — includes httpOnly cookies,
  // leaves no token file on disk.
  auth: async (page, { v }) => {
    await page.goto("/login");
    await v('input[name="email"]').fill(Deno.env.get("APP_USER")!);
    await v('input[name="password"]').fill(Deno.env.get("APP_PASSWORD")!);
    await v('button:has-text("Sign in")').click();
    await page.waitForURL("**/dashboard");
  },

  // Alternative to `auth`: reuse a captured state file.
  // storageState: "storageState.json",
};

// Each clip becomes its own .webm/.mp4 (named after the key). Helpers:
//   v(sel)      — locator with `:visible` appended (use everywhere)
//   field(label)— MUI form field by visible label text
//   sleep(ms)   — pause between actions so the video isn't a blur
// Use .fill(value), never .type(), for React-controlled inputs.
export const clips: Flow["clips"] = {
  review: async (page, { v, field, sleep }) => {
    await page.goto("/orders/123/review");
    await sleep(500);
    await field("Notes").fill("looks good");
    await sleep(300);
    await v('button:has-text("Approve")').click();
    await sleep(800);
  },
};
