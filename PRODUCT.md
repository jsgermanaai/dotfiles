# Product

## Register

product

## Users

**Primary — Jay, daily driver.** A personal dev environment used 8+ hours a day across coding, ops, writing, and incident-shaped work. Cohesion under fatigue is the success metric, not aesthetic novelty. The dotfiles are a tool worn daily; if a surface looks pretty in screenshots but reads wrong at 2am, it's wrong.

**Secondary — forkers and curious developers.** Someone clones the repo, wants to adopt the look without surgery, runs `./install.sh`, and ends up with a coherent system on their own machine. They expect documented tokens, a portable palette, and no hard-coded `/Users/jay` paths in the public surfaces. They are NOT expected to settle for a generic-developer-tool aesthetic — adopting this repo means adopting the cobalt-and-magenta point of view.

The two audiences share a single visual system. There is no separate "personal" theme and "fork-friendly" theme.

## Product Purpose

A neon-cobalt + magenta macOS dev environment, themed end-to-end across nvim, tmux, starship, lazygit, fzf, bat, ccstatusline, and the zsh prompt — reproducible from one script (`install.sh`).

The purpose is twofold and the two halves reinforce each other:

1. **Cohesion across surfaces.** Cobalt (`#2D5BFF`) and magenta (`#FF1FE7`) land identically on every TUI. A glance from the prompt to the tmux statusline to the lazygit pane reads as the same system. Drift in hex values, glyph use, or accent rhythm is the enemy.
2. **Documentation as the showcase.** The mkdocs site at `site/` (sourced from `docs/`) documents the system so cohesion is *provable*. Every config has a docs page; every page has a screenshot; the palette page is the canonical hex reference. The site is not marketing — it is the system, indexed.

Success looks like:
- Jay opens a fresh shell → prompt + statusline read correctly under fatigue, no color clash, glyphs at intended weight.
- Forker runs `./install.sh` on a clean macOS box → ends up with the same coherent system, no manual fix-ups.
- Visitor lands on the docs site → can find any token, glyph, or behavior in under 30 seconds.

## Brand Personality

**Hybrid: synthwave atmosphere, editorial discipline.** Two registers, one palette.

**Terminal surfaces lean kinetic-synthwave.** Saturated cobalt and magenta on near-black, glyph-rich starship prompt, mono-fluent labels, late-night-coder energy. The colors are load-bearing signal, not background atmosphere — cobalt anchors directory and branch context, magenta carries command emphasis and contextual state markers (git dirty, command-failure prompt, segment separators in active state). The terminal feels like a deliberately-themed instrument panel, not a stock IDE.

**Documentation site leans editorial-technical.** Long-form-friendly typography on `site/`, systematic walkthroughs (palette / prompt / nvim / tmux / lazygit / install pages), careful information architecture, before-and-after screenshots that show the actual themes rather than mocked variants. The site explains the system; the terminal proves it.

Three words for the system as a whole: **kinetic, deliberate, instrumented.**

Voice: first-person personal without being chatty. The README is technically specific ("starship prompt with 13 contextual segments", "tmux with TPM and session auto-restore", "Mason-managed LSPs"), not aspirational. Headlines carry a point of view; supporting copy reads like notes from someone who actually uses the thing every day. No marketing intensifiers.

## Anti-references

If a surface starts to resemble any of these, it has failed.

- **Generic Dracula / Catppuccin clone.** Mainstream dark-mode palettes that ship as defaults across half the developer ecosystem. The cobalt + magenta combination is specifically NOT one of these popular packages — that's the point. If a theme tweak or a docs page ever drifts toward "could be any popular dark theme", it's wrong.
- **Corporate / VSCode-default blue-gray.** Microsoft Cascadia, default macOS Terminal, generic enterprise developer-tool aesthetics. Under-committed. The dotfiles must not feel like a Microsoft product or an out-of-the-box install.

Cross-cutting (carried from impeccable, interpreted for this project):
- Hero-metric template — banned everywhere, including the docs site.
- Identical card grids of "icon + heading + body" — the README is already a counter-example (table-rich, screenshot-rich); maintain that pattern on the docs site.
- Glassmorphism as default — visual depth comes from saturation contrast and 1-px structural lines, not blur.
- Em dashes in copy — use commas, colons, semicolons, periods, or parentheses. Also not `--`.

## Design Principles

1. **Cohesion is the proof.** Cobalt and magenta land identically on every TUI surface. If a value drifts (the bat theme's blue is a slightly different blue than starship's, the lazygit accent is one shade off), fix the value. Drift is the bug, not "close enough".
2. **The docs site documents the system, not the aesthetic.** Pages exist so the canonical reference is one click away — the palette page shows real hex values; the prompt page shows real glyph names with Unicode codepoints; the install page shows what actually runs (not a sanitized version). The mkdocs site is the source-of-truth index.
3. **Glyph density is calibrated, not maximized.** Nerd Font glyphs are kept where they carry meaning (git branch / dirty status, k8s context, Azure subscription, battery, time, command-status indicator). Glyphs are part of the atmosphere AND part of the signal — never strung together as "personality" garnishes. The bar: a glyph earns its place by saying something a label couldn't.
4. **Legibility under fatigue.** Saturated cobalt and magenta only ever appear on near-black surfaces — never magenta on cobalt, never either on a light surface. Statusline and prompt meaning is never color-only — git-dirty is also a glyph; failure state is also a prompt-character change; battery state is also a percentage.
5. **Forkability without abandonment.** No hard-coded `/Users/jay` paths in public surfaces (configs, docs, install.sh — `~` and `${HOME}` everywhere). Tokens are named and documented on the palette page. Install path is forgiving (skip flags, idempotent). But the aesthetic is not softened to be "approachable" — adopting this repo means adopting the point of view; the look IS the value.

## Accessibility & Inclusion

**High-contrast under fatigue.** Calibrated for daily personal use, not formal WCAG conformance, but the docs site (a public surface) still hits AA where the surface allows.

- Cobalt and magenta appear at full saturation only on near-black surfaces. Never magenta on cobalt. Never either on a light surface. (When the docs site is rendered in a light browser theme by user choice, accent placements are re-tinted to maintain AA contrast.)
- Statusline and prompt meaning is never color-only. The git-dirty marker is also a glyph (`!`/`?`/`+`); the k8s context is also text; the battery state is also a percentage; the failure state is also a prompt-character change (`❯` → `✘`).
- Docs site (`site/`, sourced from `docs/`) targets WCAG 2.2 AA contrast for body and headings. Code blocks showing the actual neon palette are exempt — they're reproducing the system, not running for legibility.
- TUI surfaces follow terminal-color best practices for foreground/background separation; formal WCAG AA is not pursued there (the AA contrast model is HTML-shaped).
- Default install does not assume a Nerd Font is present until the script confirms `JetBrainsMono Nerd Font` is brewed and active. Glyphs gracefully degrade to ASCII if the font is missing (per starship config).
- Focus states on docs-site interactive elements are clearly styled beyond browser defaults.
- Reduced-motion is honored on the docs site — no scroll-driven choreography that breaks the reading flow.
