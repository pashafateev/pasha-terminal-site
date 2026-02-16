# 3D Terminal Redesign — Implementation Plan

## Concept
Transform the professional card site into a persistent "3D terminal" environment with layered depth.
Navigation should feel like moving through terminal files: same shell, deeper context, clear path state.

## Iteration Rules
- Keep the site shippable after every phase.
- Prefer progressive enhancement: core navigation/content works without JavaScript.
- Each phase has explicit acceptance criteria and rollback-safe scope.
- Defer non-essential visual effects until core routing/content parity is complete.

---

## Phase 0: Guardrails & Baseline

### Scope
- Capture baseline behavior and visuals before redesign.
- Define a short regression checklist for every phase.

### Files
- `README.md` (optional notes)
- `PLAN.md` (this document)

### Deliverables
- Route checklist: `/`, `/blog`, blog post route, resume PDF link, external links.
- Baseline screenshots (home/blog/post) for comparison during iteration.
- Validation commands to run each phase:
  - `npm run build`
  - `npm run preview` smoke check (manual)

### Acceptance Criteria
- Baseline routes and assets are documented.
- Validation steps are clear and repeatable.

---

## Phase 1: Visual Foundation (No Content Rewrite Yet)

### Scope
- Build terminal design tokens and shared shell/chrome.
- Keep existing pages functional, only wrapped/rethemed.

### Tasks
1. Terminal color system and typography
- **Files**: `tailwind.config.mjs`, `src/styles/global.css`, `src/layouts/BaseLayout.astro`
- Replace Lato with JetBrains Mono.
- Add terminal CSS variables:
  - `--term-bg` `#0a0e14`
  - `--term-fg` `#c5c8c6`
  - `--term-green` `#39ff14`
  - `--term-dim` `#5c6370`
  - `--term-blue` `#61afef`
  - `--term-red` `#ff5f56`
  - `--term-yellow` `#ffbd2e`
  - `--term-green-dot` `#27c93f`
- Add cursor blink and subtle glow animations.
- Add reduced-motion handling (`prefers-reduced-motion`).

2. Terminal shell component
- **New file**: `src/components/Terminal.astro`
- Includes title bar, content body, and status bar slots.
- Supports props for current path/status hints.

3. Layout integration
- **File**: `src/layouts/BaseLayout.astro`
- Apply dark background/vignette and terminal defaults.
- Keep current routes rendering with minimal behavioral change.

### Acceptance Criteria
- `/` and `/blog` still render and navigate correctly.
- `npm run build` passes.
- Theme tokens are centralized and reusable.
- No keyboard shortcuts or command logic introduced yet.

---

## Phase 2: Content Migration (Static Terminal UX)

### Scope
- Rewrite page content into terminal-style static output.
- No interactive command parser yet.

### Tasks
1. Home shell rewrite
- **File**: `src/pages/index.astro`
- Replace `Card.astro` usage with `Terminal.astro`.
- Render pre-baked command output (`whoami`, `cat about.txt`, `ls links`, `help`).
- Keep links as semantic anchors for no-JS support.

2. Blog list terminal rewrite
- **File**: `src/pages/blog/index.astro`
- Render posts as terminal-like listing output.
- Keep links to individual post routes.

3. Blog post reader parity
- **Files**: `src/layouts/BlogPost.astro`, `src/pages/blog/[...slug].astro` (or existing equivalent)
- Ensure post route exists and uses terminal-themed reader layout.
- Terminal header metadata (`cat file`, date/tags) + readable content styling.

### Acceptance Criteria
- `/`, `/blog`, and blog post route all render in terminal style.
- All navigation works without JavaScript.
- Resume link still downloads from `public/files/resume-cv.pdf`.
- External links remain valid.

---

## Phase 3: Layered Navigation & Transitions

### Scope
- Add "depth" behavior between pages while keeping accessibility intact.

### Tasks
1. View transitions
- **File**: `src/layouts/BaseLayout.astro`
- Enable Astro View Transitions.
- Keep terminal chrome stable while content pane transitions.

2. Direction-aware motion
- Forward navigation: slide content in from right.
- Back navigation: slide content in from left (or inverse animation).
- Respect `prefers-reduced-motion`.

3. Path/status synchronization
- Ensure title/status bars reflect route context (`~`, `~/blog`, `~/blog/post`).

### Acceptance Criteria
- Route transitions are visually directional and not jarring.
- Reduced motion disables non-essential animation.
- Keyboard/browser back works with correct transition direction.

---

## Phase 4: Interactive Prompt (Progressive Enhancement)

### Scope
- Introduce client-side command input as enhancement.
- Non-JS mode remains fully usable.

### Tasks
1. Prompt component
- **New file**: `src/components/Prompt.astro`
- Blinking cursor + input handling.
- Commands:
  - `about` -> jump/focus about section
  - `blog` -> navigate to `/blog`
  - `links` -> jump/focus links block
  - `resume` -> open/download CV
  - `help` -> print help output
  - `clear` -> clear prompt session output only

2. Input ergonomics
- Arrow up/down history.
- Tab completion optional, only if low complexity.
- Do not hijack keys inside regular text inputs.

3. Global shortcuts
- `/` focus prompt
- `Esc` blur prompt
- `q` back navigation when focus is not in prompt/input fields

### Acceptance Criteria
- With JS off: site remains fully navigable via links.
- With JS on: prompt commands work and degrade safely on unknown command.
- Keyboard shortcuts do not break accessibility or native browser behavior.

---

## Phase 5: Polish, Responsive, Cleanup

### Scope
- Add optional aesthetic effects, finish responsive behavior, remove obsolete components/styles.

### Tasks
1. Responsive hardening
- Mobile terminal edge-to-edge layout.
- Keep base font readable (minimum `14px` for body text).
- Ensure touch target size is adequate.

2. Optional effects
- Subtle scanlines, glow, depth shadow.
- Effects remain restrained and can be toggled off easily.

3. Cleanup
- Remove `src/components/Card.astro`.
- Remove `src/styles/card.css`.
- Remove stale imports/references.

4. Final regression
- Build + route smoke test + link verification.

### Acceptance Criteria
- No remaining dependency on old card component/styles.
- Mobile and desktop both usable and readable.
- All planned routes/assets pass regression checklist.

---

## File Change Summary (Planned)

| Action | File | Description |
|--------|------|-------------|
| Edit | `tailwind.config.mjs` | Terminal colors, fonts, animations |
| Edit | `src/styles/global.css` | Base terminal styles, motion, scrollbar |
| Create | `src/components/Terminal.astro` | Persistent terminal shell component |
| Create | `src/components/Prompt.astro` | Interactive prompt enhancement |
| Edit | `src/layouts/BaseLayout.astro` | Font/theme integration, transitions |
| Edit | `src/layouts/BlogPost.astro` | Terminal-styled blog post layout |
| Edit | `src/pages/index.astro` | Static terminal home content |
| Edit | `src/pages/blog/index.astro` | Terminal-style blog listing |
| Create/Edit | `src/pages/blog/[...slug].astro` | Ensure post route exists and uses terminal reader |
| Delete (Phase 5) | `src/components/Card.astro` | Legacy component removal |
| Delete (Phase 5) | `src/styles/card.css` | Legacy style removal |

---

## Execution Order
1. Phase 0: Guardrails & baseline
2. Phase 1: Visual foundation
3. Phase 2: Static content migration
4. Phase 3: Layered transitions
5. Phase 4: Interactive prompt
6. Phase 5: Polish and cleanup

Each phase should land as a separate commit to keep rollback and iteration straightforward.

## Tracking
- Execution tracking lives in GitHub Issues.
- `PLAN.md` stays as the high-level architecture and sequencing document.
- Use `docs/github-issues-seed.md` to create the Epic + phase issues with checklists.
