# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Static single-page website for Rainos Hayes, an elite surf coach on the North Shore of O'ahu. Domain: **rainoshayes.com**.

## Architecture

- **Single file**: Everything lives in `index.html` (~860 lines) — inline CSS in `<style>`, minimal JS at the bottom
- **No build tools, no framework, no package manager** — vanilla HTML/CSS/JS
- **External dependencies**: Google Fonts (Oswald + Source Sans 3), stock images from Unsplash/Pexels CDNs
- **Design system**: CSS custom properties in `:root` for colors, fonts. Dark aesthetic with gold (#c9a84c) accents
- **Responsive breakpoints**: 768px and 480px

## Development

```bash
# Preview locally — just open the file or serve it
open deploy/index.html
# or
cd deploy && python3 -m http.server 8000
```

No build, lint, or test commands exist. Changes are made directly to `deploy/index.html`.

## Deployment

- **Host**: Netlify
- **Domain**: rainoshayes.com
- **Publish directory**: `deploy/`
- **Deploy method**: Auto-deploy from GitHub — pushing to `master` deploys the `deploy/` folder to Netlify automatically

## Key Context

- All images are **stock placeholders** intended to be replaced with original Rainos photography. See `HANDOFF.md` for the full image inventory and CDN URL patterns.
- Bio content is sourced from verified publications (WSL, Freesurf, Tracks Magazine, etc.) — details in `HANDOFF.md`.
- Andy Irons is listed in the athlete marquee but Rainos described himself as a "corner man," not a formal coach. This may need adjustment per Rainos's preference.
- The JS is a single IntersectionObserver that adds `.visible` to `.reveal` elements for scroll-triggered fade-in animations.
- The athlete marquee uses a duplicated list of names with CSS `@keyframes marquee` for infinite horizontal scroll.
