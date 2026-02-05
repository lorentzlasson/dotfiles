---
argument-hint: <github-pr-url>
allowed-tools: Bash(gh:*)
disable-model-invocation: true
---

extract the PR number and repo from the provided GitHub URL using `gh`.

fetch the PR diff and all review comments using `gh api` and `gh pr`.

for each review comment:
- summarize what the reviewer is asking for
- assess whether the feedback is valid/reasonable
- recommend action: agree and fix, push back, or discuss further

output the analysis locally. do NOT post anything to GitHub.
