# 3D Terminal Redesign - GitHub Issues Seed

Use this file to create tracking issues in GitHub. Keep `PLAN.md` as strategy and architecture, and use these issues as execution checklists.

## Labels
- `redesign`
- `phase`
- `frontend`
- `a11y`
- `enhancement`

## Milestone
- `3D Terminal Redesign`

## Issue 0 (Epic)
Title: `Epic: 3D Terminal Redesign`

Body:
```md
## Goal
Implement the terminal redesign in iterative, shippable phases.

## Child Issues
- [ ] Phase 0 - Guardrails & Baseline
- [ ] Phase 1 - Visual Foundation
- [ ] Phase 2 - Content Migration (Static Terminal UX)
- [ ] Phase 3 - Layered Navigation & Transitions
- [ ] Phase 4 - Interactive Prompt (Progressive Enhancement)
- [ ] Phase 5 - Polish, Responsive, Cleanup

## Definition of Done
- [ ] All phase issues closed
- [ ] Final regression pass complete
- [ ] `Card.astro` and `card.css` fully removed
```

---

## Issue 1
Title: `Phase 0: Guardrails & Baseline`

Body:
```md
## Scope
Capture baseline behavior and define recurring validation checks.

## Checklist
- [ ] Document route checklist (`/`, `/blog`, blog post route, resume PDF, external links)
- [ ] Capture baseline screenshots (home/blog/post)
- [ ] Confirm validation commands (`npm run build`, `npm run preview`)

## Acceptance Criteria
- [ ] Baseline routes/assets documented
- [ ] Validation steps are repeatable
```

## Issue 2
Title: `Phase 1: Visual Foundation`

Body:
```md
## Scope
Introduce terminal tokens and shell chrome without rewriting content flows.

## Checklist
- [ ] Add terminal theme tokens in `tailwind.config.mjs` and `src/styles/global.css`
- [ ] Replace Lato with JetBrains Mono in `src/layouts/BaseLayout.astro`
- [ ] Create `src/components/Terminal.astro`
- [ ] Integrate terminal shell into layout with minimal behavior changes
- [ ] Add reduced motion handling

## Acceptance Criteria
- [ ] `/` and `/blog` render correctly
- [ ] `npm run build` passes
- [ ] No prompt/shortcut behavior introduced in this phase
```

## Issue 3
Title: `Phase 2: Content Migration (Static Terminal UX)`

Body:
```md
## Scope
Move content into static terminal presentation while preserving no-JS navigation.

## Checklist
- [ ] Rewrite `src/pages/index.astro` using terminal output blocks
- [ ] Rewrite `src/pages/blog/index.astro` as terminal listing
- [ ] Update `src/layouts/BlogPost.astro` to terminal reader style
- [ ] Ensure blog post route exists and uses reader layout (`src/pages/blog/[...slug].astro` or equivalent)
- [ ] Verify resume download and external links

## Acceptance Criteria
- [ ] `/`, `/blog`, and blog post route render in terminal style
- [ ] Navigation works without JavaScript
- [ ] Resume and external links work
```

## Issue 4
Title: `Phase 3: Layered Navigation & Transitions`

Body:
```md
## Scope
Add depth transitions and route-context state.

## Checklist
- [ ] Enable Astro view transitions in `src/layouts/BaseLayout.astro`
- [ ] Implement directional forward/back transitions
- [ ] Keep terminal chrome stable while content transitions
- [ ] Ensure path/status bars reflect route context
- [ ] Respect `prefers-reduced-motion`

## Acceptance Criteria
- [ ] Transitions are directional and stable
- [ ] Reduced-motion behavior is correct
- [ ] Browser back/forward behaves correctly
```

## Issue 5
Title: `Phase 4: Interactive Prompt (Progressive Enhancement)`

Body:
```md
## Scope
Add command prompt UX with safe degradation when JavaScript is disabled.

## Checklist
- [ ] Create `src/components/Prompt.astro`
- [ ] Implement commands: `about`, `blog`, `links`, `resume`, `help`, `clear`
- [ ] Add command history (arrow up/down)
- [ ] Add safe unknown-command output
- [ ] Add shortcuts: `/` focus prompt, `Esc` blur prompt, `q` back (outside inputs)
- [ ] Ensure keys are not hijacked in text inputs

## Acceptance Criteria
- [ ] JS-off mode remains fully usable via links
- [ ] JS-on command prompt works reliably
- [ ] Keyboard behavior is accessible and predictable
```

## Issue 6
Title: `Phase 5: Polish, Responsive, Cleanup`

Body:
```md
## Scope
Finalize responsive behavior, apply restrained polish, remove legacy artifacts.

## Checklist
- [ ] Mobile hardening (edge-to-edge terminal, touch target spacing)
- [ ] Keep body text readable (minimum 14px)
- [ ] Add optional subtle effects (scanline/glow/shadow)
- [ ] Remove `src/components/Card.astro`
- [ ] Remove `src/styles/card.css`
- [ ] Remove stale imports/references
- [ ] Final regression run

## Acceptance Criteria
- [ ] No remaining dependency on old card component/styles
- [ ] Desktop and mobile UX are both solid
- [ ] Full route/link regression passes
```

---

## Suggested Creation Order
1. Create Epic first.
2. Create Phase 0-5 issues and link each to the Epic.
3. Add labels/milestone during creation.
4. Track progress only in issues; keep `PLAN.md` as the stable intent document.
