# Rainos Hayes — rainoshayes.com

## Project Handoff: Claude.ai → Claude Code

### What this is

A static single-page website for Rainos Hayes, an elite surf coach based on the North Shore of O'ahu. This is his professional calling card as he transitions from coaching CT-level athletes (most notably Italo Ferreira) into building his own surf school and coaching platform.

The domain is **rainoshayes.com**.

### Current state

One file: `index.html` (864 lines, ~26KB). Single self-contained HTML file with inline CSS and JS. No build tools, no framework, no dependencies beyond two Google Fonts (Oswald, Source Sans 3) and external stock photography URLs.

The file is a complete, deployable static site. It renders correctly when opened in any browser with an internet connection (fonts and images load from CDNs).

### Architecture

- **Single HTML file** with all CSS in a `<style>` block and minimal JS (IntersectionObserver for scroll-reveal animations)
- **No framework**; vanilla HTML/CSS/JS
- **External dependencies**: Google Fonts (Oswald + Source Sans 3), Unsplash image CDN, Pexels image CDN
- **Design system**: CSS custom properties in `:root` for all colors, fonts
- **Responsive**: media queries at 768px and 480px breakpoints

### Design direction

- **Aesthetic**: Bold, athletic, dark. Black/charcoal backgrounds, warm gold (#c9a84c) accents, off-white (#f0ece6) text
- **Typography**: Oswald (display/headings, uppercase), Source Sans 3 (body, weight 300)
- **Effects**: Subtle film grain overlay via SVG filter, scroll-reveal animations, hover states on cards, infinite marquee scroll for athlete names
- **Layout**: Full-viewport hero with background image, alternating dark section backgrounds, 2-column grids

### Page sections (in order)

1. **Nav** — Fixed top bar. Logo "Rainos Hayes" with gold accent on "Hayes". Links to About, Services, Athletes, Contact
2. **Hero** — Full-viewport. Barrel wave background image. Name in large display type. Subhead. Three stat callouts (30+ years, 3x ISA gold, 50+ athletes)
3. **About** — Two-column grid. Left: bio text (3 paragraphs). Right: placeholder portrait image (3:4 ratio) + credential list (5 items)
4. **Image break** — Full-width aerial ocean photo divider
5. **Services** — 2x2 grid of cards, each with header image + numbered content:
   - 01: Private 1-on-1 Coaching
   - 02: Group Clinics & Camps
   - 03: Video Analysis
   - 04: Competition Prep
6. **Athletes** — Infinite-scroll marquee of athlete names (Italo Ferreira highlighted in gold). Featured callout card for the Italo/2024-2025 coaching relationship
7. **Contact** — Full-section background image (beach sunset), centered CTA with email link (rainos@rainoshayes.com) and location
8. **Footer** — Copyright + photo credit note

### Stock images currently in use

All images are placeholders. The intent is to replace every one with original photography from Rainos. Current sources:

| Location | Source | Photo ID | Notes |
|---|---|---|---|
| Hero background (CSS) | Unsplash | photo-1502680390548-bdbac40e4a9f | Barrel wave, dark overlay |
| About portrait | Unsplash | photo-1455729552865-3658a5d39692 | Surfer silhouette; **replace with Rainos portrait** |
| Image break | Unsplash | photo-1505459668311-8dfac7952bf0 | Aerial ocean shot |
| Service 01 (1-on-1) | Unsplash | photo-1502933691298-84fc14542831 | Surfer on wave |
| Service 02 (Clinics) | Unsplash | photo-1531722569936-825d3dd91b15 | Surfers in lineup |
| Service 03 (Video) | Pexels | 1654485 | Surfer in barrel (Guy Kawasaki) |
| Service 04 (Comp Prep) | Pexels | 1298684 | Barrel wave (Emiliano Arano) |
| Featured callout | Pexels | 1654485 | Same barrel shot, larger (w=1200) |
| Contact background | Unsplash | photo-1507525428034-b723cf961d3e | Tropical beach sunset |

**Known issue**: Some Unsplash photo IDs may not resolve (they were selected by ID without live verification). If any images 404, replace with working Unsplash/Pexels URLs. The URL patterns are:
- Unsplash: `https://images.unsplash.com/photo-{ID}?w={width}&q=80&auto=format&fit=crop`
- Pexels: `https://images.pexels.com/photos/{ID}/pexels-photo-{ID}.jpeg?auto=compress&cs=tinysrgb&w={width}`

### Bio content sources (all verified via web search)

Rainos Hayes credentials used in the site copy are sourced from:

- **WSL (worldsurfleague.com)**: Rainos competed on WQS and WCT; WSL athlete page confirms born June 20, 1969, first CT season 1990. WSL feature article (Jan 2017) lists athletes coached including Andy Irons, Finn McGill, Joel Centeio
- **Hawaii Surf Team (hisurfteam.org)**: Head coach 1996-2018; team podiumed every year; gold in 2005, 2012, 2014
- **Freesurf Magazine**: Billabong Hawai'i Team Manager; personal coach to Seth Moniz and Courtney Conlogue; also coached Gabriela Bryan, Malia Manuel, Keanu Asing, Zeke Lau, Albee Layer, Benji Brand, Elijah Gates
- **Tracks Magazine (March 2025)**: Both Italo Ferreira and Rio Waida are in the Rainos Hayes coaching camp in 2025; "early conversations for coach of the year"
- **DUKE Surf / Surf Hardcore (Jan 2024)**: Rainos announced as Italo Ferreira's new coach for 2024 season
- **T Patterson Surfboards (Aug 2024)**: Rainos credited as Italo's coach during 2024 Tahiti Pro win
- **Hana Hou Magazine**: Feature profile on Rainos's coaching philosophy and background

Andy Irons is listed in the athlete marquee. Rainos described himself as a "corner man" for Andy, not a formal coach. Rainos may want this adjusted.

### Immediate next steps

1. **Verify all images load** — Open `index.html` in a browser and check all 9 image locations. Replace any that 404
2. **Confirm email address** — Currently `rainos@rainoshayes.com`; verify this is correct
3. **Get Rainos's review** on:
   - Bio copy accuracy
   - Athlete list (who to include/exclude)
   - Service descriptions and pricing structure (not yet included)
   - Andy Irons inclusion
4. **Hosting setup** — Deploy to rainoshayes.com. Options:
   - Netlify (drag-and-drop deploy, free tier, custom domain + SSL)
   - Cloudflare Pages (free, fast, custom domain + SSL)
   - Vercel (free tier, custom domain + SSL)
   - Any static host; it's one HTML file with zero build step
5. **DNS** — Point rainoshayes.com to whichever host. Add CNAME or A record per host instructions

### Future iterations

- Replace all stock photos with original Rainos photography
- Add a booking/inquiry form (Calendly embed, Typeform, or custom)
- Testimonials section (quotes from athletes)
- Instagram feed integration
- Video embed (coaching reel or session footage)
- Pricing section or separate pricing page
- SEO: Open Graph tags, structured data, sitemap
- Analytics: add Plausible or Fathom (privacy-respecting) tracking snippet
- Consider migrating to a lightweight static site generator (11ty, Astro) if the site grows beyond 2-3 pages

### For Claude Code

To pick this up:

```bash
# 1. Create the project directory
mkdir -p ~/projects/rainoshayes.com
cd ~/projects/rainoshayes.com

# 2. Copy index.html into the project root
# (download from Claude.ai conversation or paste contents)

# 3. Verify it works
open index.html
# or: python3 -m http.server 8000 && open http://localhost:8000

# 4. Initialize git
git init
git add index.html HANDOFF.md
git commit -m "Initial commit: static single-page site for Rainos Hayes"
```

The file is fully self-contained. No `npm install`, no build step, no config files needed. Just serve the HTML.
