#!/usr/bin/env -S deno run --quiet --allow-env=HOME

type Input = {
  model: { display_name: string }
  workspace: { current_dir: string }
  context_window: { remaining_percentage: number | null }
}

const input: Input = JSON.parse(await new Response(Deno.stdin.readable).text())

const dim = (s: string) => `\x1b[2m${s}\x1b[0m`
const red = (s: string) => `\x1b[31m${s}\x1b[0m`
const yellow = (s: string) => `\x1b[33m${s}\x1b[0m`
const green = (s: string) => `\x1b[32m${s}\x1b[0m`
const cyan = (s: string) => `\x1b[36m${s}\x1b[0m`

const color = (left: number) =>
  left <= 20 ? red : left <= 50 ? yellow : green

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

const model = input.model.display_name.charAt(0)
const home = Deno.env.get("HOME")
const cwd = input.workspace.current_dir
const dir = home && (cwd === home || cwd.startsWith(`${home}/`))
  ? `~${cwd.slice(home.length)}`
  : cwd
const left = Math.round(input.context_window.remaining_percentage ?? 100)

console.log([
  modelColor(model)(model),
  color(left)(`${left}%`),
  dim(dir),
].join(dim(" · ")))
