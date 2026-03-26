# AGENTS.md

## Project

Pasha's personal portfolio site — an Astro 4 static site with a terminal/shell aesthetic. IBM Plex Mono font, dark theme, CRT effects. Deployed to Vercel at pashafateev.dev.

## Stack

- **Framework**: Astro 4 (static output)
- **Styling**: Tailwind CSS + scoped component styles
- **Font**: IBM Plex Mono (400, 600, 700)
- **Deployment**: Vercel
- **Package manager**: npm (pnpm-lock.yaml present but npm is used in CI)

## Build & Dev

```bash
npm run build      # production build — must pass before every commit
npm run dev        # dev server (defaults to port 4321; use --port XXXX to override)
npm run preview    # preview production build
```

Port 12000 is reserved by the runtime environment. The dev server auto-increments to 12001 when run with `--port 12000`.

To allow the preview hosts in dev, add to `astro.config.mjs` temporarily (do NOT commit):
```js
vite: { server: { allowedHosts: ['work-1-aerxcskobahcixem.prod-runtime.all-hands.dev', 'work-2-aerxcskobahcixem.prod-runtime.all-hands.dev'] } }
```

## Key Source Files

| File | Purpose |
|------|---------|
| `src/components/Terminal.astro` | Shell chrome: titlebar, dots, statusbar, CRT effects |
| `src/components/Prompt.astro` | Interactive command prompt (home page) |
| `src/layouts/BaseLayout.astro` | HTML shell, SEO meta, font load, view transitions |
| `src/layouts/BlogPost.astro` | Blog post reader layout |
| `src/pages/index.astro` | Home page |
| `src/pages/blog/index.astro` | Blog listing with tag filters and j/k keyboard nav |
| `src/pages/blog/[...slug].astro` | Blog post page — computes newerSlug/olderSlug for inter-post nav |
| `src/styles/global.css` | CSS custom properties (terminal color tokens), global styles, animations |

## CSS Tokens

```
--term-bg, --term-fg, --term-green, --term-dim, --term-blue,
--term-red, --term-yellow, --term-green-dot
```

## PR Workflow

### Reviewing Comments

When babysitting or checking a PR for reviewer feedback:

1. **Address every actionable comment** — fix the code, commit with `chore: address PR review feedback (#N)`, and push.
2. **After pushing fixes**, use the GitHub API or `gh` CLI to **resolve the comment thread** if possible, or **leave a reply** on the comment explaining what was changed and why (especially if the fix differs from the suggestion or if a comment is intentionally not acted on).
3. **If a comment is not actionable** (already handled, out of scope, or disagreed with), still reply to the thread explaining the decision rather than silently ignoring it.
4. Resume watching the PR after every push.

This ensures reviewers (human and bot) can see their feedback was heard and the PR history is clear.

### Branch naming

Feature/fix branches: `feat/`, `fix/`, `chore/` prefixes. Example: `feat/terminal-polish-keyboard-nav`.

### Commit style

```
feat: short description (#issue)
fix: short description
chore: address PR review feedback (#PR)
```

Always add `Co-authored-by: openhands <openhands@all-hands.dev>` to commits.

## Open Issues (as of last session)

| # | Title | Priority |
|---|-------|----------|
| #25 | Blog page loses terminal experience — interactive redesign | now |
| #45 | Improve mobile touch behavior | soon |
| #36 | ASCII welcome banner | later |
| #41 | Light mode theme | later |
| #42 | Contact path | later |
| #43 | Image optimization | later |
| #44 | Link prefetching | later |
| #26 | Two-tier developer/non-developer UX | later |

Issues #10 and #33 were closed by PR #60.
