# Professional Card Astro

Terminal-style personal portfolio built with Astro.

This project now uses a command-line inspired UI for:
- Home page (`/`)
- Blog index (`/blog`)
- Blog post pages (`/blog/<slug>`)

## Tech Stack

- Astro 4
- Tailwind CSS 3 (+ typography plugin)
- TypeScript

## Features

- Terminal shell layout with status/path bars
- Animated, direction-aware page transitions (forward/back)
- Reduced motion support via `prefers-reduced-motion`
- Content collections for blog posts
- Resume PDF and profile assets served from `public/`

## Project Structure

```text
public/
  files/
    resume-cv.pdf
  images/
    profile.webp
  favicon.ico
src/
  components/
    Terminal.astro
  content/
    blog/
      welcome.md
    config.ts
  layouts/
    BaseLayout.astro
    BlogPost.astro
  pages/
    blog/
      [...slug].astro
      index.astro
    index.astro
  styles/
    global.css
```

## Getting Started

### Prerequisites

- Node.js 18+
- npm

### Install

```bash
npm install
```

### Run locally

```bash
npm run dev
```

App runs at `http://localhost:4321`.

### Build

```bash
npm run build
```

### Preview production build

```bash
npm run preview
```

## Content and Customization

### Home page

Edit `src/pages/index.astro` for:
- Intro/about text
- External links (GitHub, LinkedIn)
- Resume link

### Blog

- Add posts under `src/content/blog/*.md`
- Frontmatter schema is defined in `src/content/config.ts`
- Quick flow (branch + commit + push + PR): `npm run post:new -- "Post Title" "Description" "tag1,tag2"`

Required frontmatter:
- `title`
- `description`
- `pubDate`

Optional frontmatter:
- `updatedDate`
- `heroImage`
- `tags`

### Global styles

- Terminal theme and transitions: `src/styles/global.css`
- Shell wrapper component: `src/components/Terminal.astro`

## Scripts

- `npm run dev` - start dev server
- `npm run build` - build site to `dist/`
- `npm run preview` - preview production build
- `npm run astro` - run Astro CLI commands
- `npm run post:new -- "Post Title" "Description" "tag1,tag2"` - create blog post file, branch, commit, push, and PR

## Deployment

Deploy the generated `dist/` folder to any static host (Netlify, Vercel, Cloudflare Pages, GitHub Pages, etc.).

## License

MIT. See `LICENSE.txt`.
