# Global Agent Workflow

Apply these rules in every project unless a higher-priority system/developer instruction conflicts.

## 1) Output Formatting (Non-Negotiable)

- Never post escaped newline text like `\\n` in PR/issue comments, summaries, or status updates.
- Write human-readable Markdown with real line breaks and lists.
- Before submitting a GitHub comment/PR body, sanity-check readability in plain text.
- If formatting is broken, fix it before posting.

## 2) Commit and Branch Discipline

- Commit each completed task before starting the next task.
- Always push after committing.
- Do not batch unrelated work into one commit.
- Keep each commit focused to files relevant to that task.
- Prefer short descriptive branch names per change (for example: `fix/<topic>`, `feat/<topic>`, `docs/<topic>`).

## 3) GitHub Issue and PR Lifecycle

- When starting work on an issue, post an "in progress" tracking comment and include the working branch or PR.
- Use `gh` CLI for GitHub operations when available.
- Open one PR per scoped change and include verification evidence.
- Include concrete test evidence in PR descriptions (commands + pass count, e.g. `127 passed`).
- Link PRs to issues using closing keywords when appropriate (for example: `Closes #23`).
- Do not close issues before the implementing PR is merged.
- After merge, close linked issues with a final comment referencing the merged PR or merge commit.

## 4) Task Selection and Progression

- When deciding "what next," base it on open issues, recent commits, and current test status.
- Prioritize reconciling issues that appear already fixed by recent commits/PRs.
- Ship one concrete improvement at a time: implement -> test -> commit -> PR.

## 5) Testing and Reporting

- Run targeted tests for changed components first.
- Run the full suite before opening or updating a PR when practical.
- Report test outcomes with concrete numbers, not generic statements.

## 6) Sandbox / Permissions

- If sandboxing blocks required GitHub/network/auth commands, request elevated execution per environment policy rather than skipping verification.
