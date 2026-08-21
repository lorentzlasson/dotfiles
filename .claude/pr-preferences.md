## Pull request title and description

Applies to every PR I open, however it is asked for — `/pr`, "put up a PR", "open a PR", or as the tail end of some other task.

- use lowercase for all text
- high-level descriptive title (max ~72 chars)
- no headers in description
- no test plan section
- description focuses on WHY, not WHAT
- default to NO body. the title carries the change; a body is the exception, not the norm.
- add a body ONLY for information absent from both title and diff — perf numbers, an invariant the change preserves, a non-obvious why, a link to an issue. never restate or summarize the diff.
- when a body is warranted, keep it to 1-3 short bullets, max ~3 lines total. if it runs longer, it's saying too much — cut it.
- when the change alters flow of logic or an algorithm such that a flowchart would clarify it, append a mermaid flowchart as the last element of the body inside a `<details>` tag.
- when a PR has a companion PR in another repo, each links to the other by URL.

These rules also govern edits to an existing PR's title or body.
