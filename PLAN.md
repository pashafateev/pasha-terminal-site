# 3D Terminal Redesign — Implementation Plan

## Concept
Transform the professional card site into a "3D terminal" — a persistent terminal environment
with depth. You're always inside the terminal. Content slides forward like opening files in
`vim` or `less`. You never leave the session.

---

## Phase 1: Foundation — Terminal Theme & Layout

### 1.1 Terminal Color System & Typography
- **File**: `tailwind.config.mjs`, `src/styles/global.css`
- Replace Lato with a monospace font (JetBrains Mono via Google Fonts)
- Define terminal color palette as CSS custom properties:
  - `--term-bg`: deep black (#0a0e14)
  - `--term-fg`: light gray (#c5c8c6)
  - `--term-green`: terminal green (#39ff14)
  - `--term-dim`: muted gray (#5c6370)
  - `--term-blue`: accent blue (#61afef)
  - `--term-red`: dot red (#ff5f56)
  - `--term-yellow`: dot yellow (#ffbd2e)
  - `--term-green-dot`: dot green (#27c93f)
- Add CSS animations: cursor blink, subtle glow, typing effect
- Custom scrollbar styling (thin, dark, green thumb)

### 1.2 Terminal Window Component
- **New file**: `src/components/Terminal.astro`
- The persistent chrome that wraps everything:
  - **Title bar**: Three dots (red/yellow/green) + path text (e.g., `pasha@site:~$`)
  - **Body**: Dark content area with padding, monospace text
  - **Status bar** (bottom): Shows context like `[q quit] [↑↓ scroll]` or current path
- This replaces `Card.astro` as the main visual container
- Accepts slots for content

### 1.3 Update BaseLayout
- **File**: `src/layouts/BaseLayout.astro`
- Swap Google Fonts from Lato to JetBrains Mono
- Update meta/title
- Full dark background with subtle vignette effect
- Import new terminal styles

---

## Phase 2: Home Page — The Shell (Layer 1)

### 2.1 Redesign index.astro
- **File**: `src/pages/index.astro`
- Replace the Card component with Terminal component
- Content rendered as terminal output:
  ```
  $ whoami
  Pasha Fateev — Software Engineer

  $ cat about.txt
  Backend-focused engineer working on distributed systems...
  Currently building things at AutoKitteh.
  Python, Go, and whatever gets the job done.

  $ ls links/
  > github       linkedin       blog       resume.pdf

  $ help
  Available commands:
    about     — who I am
    blog      — read my writing
    links     — find me online
    resume    — download my CV
    help      — show this message
  ```
- Each "command" is pre-rendered (not actually typed) — static but styled as terminal output
- Links section: icons + labels, styled as terminal list items
- Profile image: optional — could appear as ASCII art or small circular image in the "about" output

### 2.2 Interactive Prompt (Client-Side)
- **New file**: `src/components/Prompt.astro` (with `<script>` tag for client JS)
- Blinking cursor at the bottom of the terminal
- User can actually type commands:
  - `about` → scrolls to / re-renders about section
  - `blog` → navigates to `/blog`
  - `links` → scrolls to links section
  - `resume` → triggers PDF download
  - `help` → shows help text
  - `clear` → clears terminal output
- Arrow up/down for command history
- Tab completion (nice-to-have)
- This is progressive enhancement — site works without JS, commands are just links

---

## Phase 3: Blog — Going Deeper (Layer 2)

### 3.1 Blog Listing Page
- **File**: `src/pages/blog/index.astro`
- Wrapped in Terminal component
- Title bar shows: `pasha@site:~/blog`
- Content styled as `ls -la` output:
  ```
  $ ls -la ~/blog/

  total 3
  drwxr-xr-x  2024-03-20  welcome.md          Welcome to My Blog
  drwxr-xr-x  2024-04-15  distributed-sys.md  Lessons in Distributed Systems
  ```
- Each entry is a link to the full post
- Tags shown as `[tag1, tag2]` after description
- Back navigation: `$ cd ~` link at bottom

### 3.2 Blog Post Reader
- **File**: `src/layouts/BlogPost.astro`
- Terminal chrome persists — you're still in the terminal
- Title bar updates: `pasha@site:~/blog/post-slug`
- Header shows:
  ```
  $ cat welcome.md
  ═══════════════════════════════════════
  Welcome to My Blog
  2024-03-20  •  #welcome  #first-post
  ═══════════════════════════════════════
  ```
- Content area: readable typography but terminal-themed
  - Slightly larger line height for readability
  - Green for headings and links
  - Code blocks look native (they're already in a terminal!)
  - Blockquotes with `>` prefix styling
- Status bar at bottom: `[← back to blog] [↑ top]`
- `q` keypress navigates back to blog listing

### 3.3 View Transitions
- **File**: `src/layouts/BaseLayout.astro`
- Enable Astro View Transitions (`<ViewTransitions />`)
- Terminal chrome stays fixed during page transitions
- Content area transitions: slide-in from right when going deeper, slide-out when going back
- This creates the "3D depth" effect — layers sliding in/out within the terminal frame

---

## Phase 4: Polish & Responsiveness

### 4.1 Keyboard Navigation
- Add global keyboard listener (in BaseLayout or a script):
  - `q` — go back (when not in prompt input)
  - `/` — focus the command prompt
  - `Esc` — blur prompt / go home
- Ensure all commands also work via mouse/touch

### 4.2 Responsive Design
- Mobile: Terminal fills viewport edge-to-edge
- Smaller font size on mobile (14px → 12px)
- Title bar simplified on small screens
- Touch targets: links/commands have adequate padding
- Status bar stays fixed at bottom on mobile

### 4.3 Subtle Effects
- CRT scanline overlay (very subtle, CSS-only, optional)
- Subtle text-shadow glow on green elements
- Terminal window slight drop shadow for "floating" depth effect
- Cursor blink matches real terminal timing (530ms on/off)

### 4.4 Cleanup
- Remove old `Card.astro` component
- Remove old `card.css` styles
- Update any remaining references
- Test all routes and navigation
- Verify PDF download still works
- Check all external links (GitHub, LinkedIn)

---

## File Change Summary

| Action | File | Description |
|--------|------|-------------|
| Edit | `tailwind.config.mjs` | Add terminal colors, fonts, animations |
| Edit | `src/styles/global.css` | Terminal base styles, animations, scrollbar |
| Delete | `src/styles/card.css` | No longer needed |
| Create | `src/components/Terminal.astro` | Terminal window chrome component |
| Create | `src/components/Prompt.astro` | Interactive command prompt |
| Delete | `src/components/Card.astro` | Replaced by Terminal |
| Edit | `src/layouts/BaseLayout.astro` | New font, view transitions, dark theme |
| Edit | `src/layouts/BlogPost.astro` | Terminal-themed blog reader |
| Rewrite | `src/pages/index.astro` | Terminal shell home page |
| Rewrite | `src/pages/blog/index.astro` | Terminal-styled blog listing |

---

## Implementation Order

1. Phase 1 (Foundation) — get the terminal looking right
2. Phase 2 (Home) — rebuild the landing experience
3. Phase 3 (Blog) — wire up the depth/reader layer
4. Phase 4 (Polish) — keyboard nav, responsive, effects, cleanup

Each phase builds on the last. Site remains functional throughout.
