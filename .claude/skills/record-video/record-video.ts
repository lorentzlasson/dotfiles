#!/usr/bin/env -S deno run --allow-all
import { chromium, type Page } from "npm:playwright-core@1.59.1";
import type { Config, Flow, Helpers } from "./types.ts";

const arg = (key: string) => {
  const i = Deno.args.indexOf(`--${key}`);
  return i < 0 ? undefined : Deno.args[i + 1];
};

const flowArg = arg("flow");
if (!flowArg) {
  console.error("usage: record-video.ts --flow <flow.ts> [--out dir] [--clip name] [--headed]");
  Deno.exit(1);
}

const out = arg("out") ?? "out";
const onlyClip = arg("clip");
const headed = Deno.args.includes("--headed");
const chromePath = Deno.env.get("CHROME_PATH") ?? "/run/current-system/sw/bin/google-chrome";
const flow = (await import(new URL(flowArg, `file://${Deno.cwd()}/`).href)) as Flow;

const config: Config = flow.config ?? {};
const clips = flow.clips ?? {};
const viewport = config.viewport ?? { width: 1440, height: 810 };

const helpers = (page: Page): Helpers => ({
  sleep: (ms) => new Promise<void>((r) => setTimeout(r, ms)),
  v: (selector) => page.locator(`${selector}:visible`),
  field: (label) =>
    page.locator(`.MuiFormControl-root:visible:has-text(${JSON.stringify(label)}) input:visible`),
});

const toMp4 = async (webm: string) => {
  const mp4 = webm.replace(/\.webm$/, ".mp4");
  const ffmpeg =
    `ffmpeg -y -i '${webm}' -c:v libx264 -pix_fmt yuv420p -movflags +faststart -vf 'scale=trunc(iw/2)*2:trunc(ih/2)*2' '${mp4}'`;
  const { success, stderr } = await new Deno.Command("nix-shell", {
    args: ["--packages", "ffmpeg", "--run", ffmpeg],
  }).output();
  if (!success) {
    console.error(new TextDecoder().decode(stderr));
    throw new Error(`ffmpeg failed for ${webm}`);
  }
  return mp4;
};

const browser = await chromium.launch({ executablePath: chromePath, headless: !headed });

const acquireState = async () => {
  if (config.storageState) return config.storageState;
  if (!config.auth) return undefined;
  const ctx = await browser.newContext({ viewport, baseURL: config.baseURL });
  const page = await ctx.newPage();
  try {
    await config.auth(page, helpers(page));
    return await ctx.storageState();
  } finally {
    await ctx.close();
  }
};

const storageState = await acquireState();
const selected = onlyClip ? [onlyClip] : Object.keys(clips);

for (const name of selected) {
  const run = clips[name];
  if (!run) {
    console.error(`no clip "${name}"`);
    continue;
  }
  const ctx = await browser.newContext({
    viewport,
    baseURL: config.baseURL,
    storageState,
    recordVideo: { dir: out, size: viewport },
  });
  const page = await ctx.newPage();
  try {
    await run(page, helpers(page));
  } finally {
    await ctx.close();
  }
  const webm = `${out}/${name}.webm`;
  await Deno.rename(await page.video()!.path(), webm);
  console.log(await toMp4(webm));
}

await browser.close();
