# try postgres-mcp instead of psql cli

Currently giving Claude Code raw `psql` + a DB URL. Hard to follow what it
runs.

Try `crystaldba/postgres-mcp` (Postgres MCP Pro) as a project-scoped MCP
server. Calls render as structured tool invocations in the transcript and
schema introspection is built-in.

- Add per project (not globally) so each repo gets its own DB binding.
- Start in restricted/read-only access mode; opt into writes deliberately.
- Context cost is no longer a concern — Claude Code auto-defers MCP tool
  schemas via Tool Search since Jan 2026.

Setup sketch:
`claude mcp add postgres-pro --scope project -- uvx postgres-mcp --access-mode=restricted "$DATABASE_URL"`
