#!/usr/bin/env -S deno run --quiet --allow-env=HOME --allow-read --allow-write=/tmp/claude-statusline-usage.json --allow-net=api.anthropic.com

// <MODEL> <session>%|<weekly>%|<fable weekly>% · 🧠 <context used>% · <path>
// F 4%|6%|7% · 🧠 12% · ~/dotfiles
// fable weekly is only shown when running fable

type Input = {
  model: { display_name: string }
  workspace: { current_dir: string }
  context_window: { used_percentage: number | null }
}

type Limit = {
  kind: string
  percent: number
  scope: { model: { display_name: string } | null } | null
}

const CACHE = "/tmp/claude-statusline-usage.json"
const TTL_MS = 60_000

const input: Input = JSON.parse(await new Response(Deno.stdin.readable).text())
const home = Deno.env.get("HOME")

const dim = (s: string) => `\x1b[2m${s}\x1b[0m`
const red = (s: string) => `\x1b[31m${s}\x1b[0m`
const yellow = (s: string) => `\x1b[33m${s}\x1b[0m`
const green = (s: string) => `\x1b[32m${s}\x1b[0m`
const cyan = (s: string) => `\x1b[36m${s}\x1b[0m`

const color = (used: number) =>
  used >= 80 ? red : used >= 50 ? yellow : green

const percent = (used: number) => color(used)(`${used}%`)

const contextColor = (used: number) =>
  used >= 60 ? red : used >= 50 ? yellow : green

const contextPercent = (used: number) => contextColor(used)(`${used}%`)

const modelColor = (initial: string) => {
  switch (initial) {
    case "F":
      return red
    case "O":
      return yellow
    case "S":
    case "H":
      return green
    default:
      return cyan
  }
}

const readCache = async () => {
  try {
    const [stat, text] = await Promise.all([Deno.stat(CACHE), Deno.readTextFile(CACHE)])
    const limits: Limit[] = JSON.parse(text)
    return { age: Date.now() - (stat.mtime?.getTime() ?? 0), limits }
  } catch {
    return null
  }
}

const fetchLimits = async () => {
  const credentials = JSON.parse(await Deno.readTextFile(`${home}/.claude/.credentials.json`))
  const res = await fetch("https://api.anthropic.com/api/oauth/usage", {
    headers: {
      authorization: `Bearer ${credentials.claudeAiOauth.accessToken}`,
      "anthropic-beta": "oauth-2025-04-20",
    },
    signal: AbortSignal.timeout(2_000),
  })
  if (!res.ok) throw new Error(`usage ${res.status}`)
  const { limits }: { limits: Limit[] } = await res.json()
  await Deno.writeTextFile(CACHE, JSON.stringify(limits))
  return limits
}

const cached = await readCache()
const limits = cached && cached.age < TTL_MS
  ? cached.limits
  : await fetchLimits().catch(() => cached?.limits ?? [])

const model = input.model.display_name.charAt(0)
const usage = [
  limits.find((l) => l.kind === "session"),
  limits.find((l) => l.kind === "weekly_all"),
  ...(model === "F"
    ? [limits.find((l) => l.kind === "weekly_scoped" && l.scope?.model?.display_name === "Fable")]
    : []),
].map((limit) => limit ? percent(limit.percent) : dim("-")).join(dim("|"))

const cwd = input.workspace.current_dir
const dir = home && (cwd === home || cwd.startsWith(`${home}/`))
  ? `~${cwd.slice(home.length)}`
  : cwd
const used = Math.round(input.context_window.used_percentage ?? 0)

console.log([
  `${modelColor(model)(model)} ${usage}`,
  `🧠 ${contextPercent(used)}`,
  dim(dir),
].join(dim(" · ")))
