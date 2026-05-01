---
name: dotfiles
description: A neon-cobalt + magenta macOS dev environment, themed end-to-end across nvim, tmux, starship, lazygit, fzf, bat, ccstatusline, and an mkdocs-published documentation site.
colors:
  cobalt: "#2D5BFF"
  cobalt-light: "#3B82F6"
  cobalt-deep: "#0050E0"
  magenta: "#FF1FE7"
  magenta-soft: "#D670D6"
  purple: "#c0a3ff"
  cyan: "#22D3EE"
  green: "#22EE99"
  amber: "#F59E0B"
  yellow: "#F5C542"
  red: "#FF4D4D"
  grey: "#6b7280"
  fg: "#e0e0ee"
  carbon-pure: "#000000"
  carbon-elevated: "#0a0a14"
  carbon-active: "#1a1a3e"
  linenr-dim: "#444466"
typography:
  terminal:
    fontFamily: "'JetBrainsMono Nerd Font', 'JetBrains Mono', monospace"
    fontSize: "13px"
    fontWeight: 400
    lineHeight: 1.4
    letterSpacing: "normal"
  terminal-bold:
    fontFamily: "'JetBrainsMono Nerd Font', 'JetBrains Mono', monospace"
    fontSize: "13px"
    fontWeight: 700
    lineHeight: 1.4
    letterSpacing: "normal"
  docs-body:
    fontFamily: "'Roboto', -apple-system, BlinkMacSystemFont, sans-serif"
    fontSize: "16px"
    fontWeight: 400
    lineHeight: 1.6
    letterSpacing: "normal"
  docs-heading:
    fontFamily: "'Roboto', -apple-system, BlinkMacSystemFont, sans-serif"
    fontSize: "32px"
    fontWeight: 600
    lineHeight: 1.2
    letterSpacing: "-0.01em"
  docs-mono:
    fontFamily: "'Roboto Mono', 'JetBrains Mono', monospace"
    fontSize: "14px"
    fontWeight: 400
    lineHeight: 1.5
    letterSpacing: "normal"
rounded:
  none: "0"
  sm: "2px"
spacing:
  "1": "4px"
  "2": "8px"
  "3": "12px"
  "4": "16px"
  "5": "24px"
  "6": "32px"
components:
  prompt-segment-cobalt:
    backgroundColor: "transparent"
    textColor: "{colors.cobalt}"
    typography: "{typography.terminal-bold}"
    rounded: "{rounded.none}"
    padding: "0"
  prompt-segment-magenta:
    backgroundColor: "transparent"
    textColor: "{colors.magenta}"
    typography: "{typography.terminal-bold}"
    rounded: "{rounded.none}"
    padding: "0"
  prompt-character-success:
    backgroundColor: "transparent"
    textColor: "{colors.cobalt}"
    typography: "{typography.terminal-bold}"
    rounded: "{rounded.none}"
    padding: "0"
  prompt-character-error:
    backgroundColor: "transparent"
    textColor: "{colors.magenta}"
    typography: "{typography.terminal-bold}"
    rounded: "{rounded.none}"
    padding: "0"
  ccstatusline-cwd:
    backgroundColor: "{colors.cobalt}"
    textColor: "{colors.carbon-elevated}"
    typography: "{typography.terminal-bold}"
    rounded: "{rounded.none}"
    padding: "0 8px"
  ccstatusline-branch:
    backgroundColor: "{colors.magenta}"
    textColor: "{colors.carbon-elevated}"
    typography: "{typography.terminal-bold}"
    rounded: "{rounded.none}"
    padding: "0 8px"
  ccstatusline-changes:
    backgroundColor: "{colors.magenta-soft}"
    textColor: "{colors.carbon-elevated}"
    typography: "{typography.terminal}"
    rounded: "{rounded.none}"
    padding: "0 8px"
  lazygit-active-pane:
    backgroundColor: "transparent"
    textColor: "{colors.fg}"
    typography: "{typography.terminal}"
    rounded: "{rounded.none}"
    padding: "0"
  nvim-float-border:
    backgroundColor: "{colors.carbon-elevated}"
    textColor: "{colors.fg}"
    typography: "{typography.terminal}"
    rounded: "{rounded.none}"
    padding: "0"
  mkdocs-link:
    backgroundColor: "transparent"
    textColor: "{colors.cobalt}"
    typography: "{typography.docs-body}"
    rounded: "{rounded.none}"
    padding: "0"
  mkdocs-admonition-default:
    backgroundColor: "{colors.carbon-elevated}"
    textColor: "{colors.fg}"
    typography: "{typography.docs-body}"
    rounded: "{rounded.sm}"
    padding: "16px"
  mkdocs-admonition-warning:
    backgroundColor: "{colors.carbon-elevated}"
    textColor: "{colors.fg}"
    typography: "{typography.docs-body}"
    rounded: "{rounded.sm}"
    padding: "16px"
  mkdocs-code-block:
    backgroundColor: "{colors.carbon-elevated}"
    textColor: "{colors.fg}"
    typography: "{typography.docs-mono}"
    rounded: "{rounded.sm}"
    padding: "12px 16px"
---

# Design System: dotfiles

## 1. Overview

**Creative North Star: "The Cobalt-and-Magenta Flight Deck"**

Each statusline, prompt line, tmux row, and mkdocs page is a row of instruments. Cobalt and magenta are not background atmosphere — they are runtime channels. Cobalt anchors *where you are* (directory, k8s context, model name, working dir segment). Magenta carries *what's happening* (git branch and status, command failure, focused element, active state). The rest of the palette is a small set of additional channels (cyan = k8s/golang, green = python venv / colima / vimcmd / cost, amber = command-too-slow / battery warn, red = failure / battery critical, purple = terraform / agents-running). Every color earns a job. The synthwave is the lighting; the flight deck is the structure.

The system is built from very few materials: one mono family with full Nerd Font glyph coverage (`JetBrainsMono Nerd Font`), a 12-token color palette plus a 3-step pure-black surface ramp, powerline-style background-block segments for statuslines, and 1-px borders for nvim float / lazygit active pane / mkdocs focused inputs. The mkdocs documentation site uses mkdocs-material as a chassis but pulls every accent and every surface back to the same palette so the docs *look like* the terminal documents itself.

What this system explicitly rejects, carried directly from PRODUCT.md: generic Dracula / Catppuccin clone (mainstream dark-mode palettes that everyone has — the cobalt+magenta combination is the point of differentiation), and corporate / VSCode-default blue-gray (Microsoft Cascadia, default macOS Terminal, generic enterprise developer-tool aesthetics). The visual identity is committed-saturated; pulling it toward a popular package or a corporate default is failure.

**Key Characteristics:**
- Two-channel system. Cobalt is *where*; magenta is *what's happening*. The other 7 colors are auxiliary runtime signal.
- Pure-black base. `#000000` is the default surface across nvim, mkdocs, and the terminal background. `#0a0a14` is the elevated tier (code blocks, statusline bg, lazygit selection, mkdocs footer). `#1a1a3e` is the active tier (nvim Visual / CursorLine).
- Powerline + 1-px lines. Statuslines (ccstatusline, tmux, lazygit) use solid background blocks with arrow separators. Nvim Telescope / floats and lazygit active pane mark focus with 1-px magenta borders. The two patterns coexist: blocks signal channels; lines signal focus.
- Glyph density is calibrated. Nerd Font glyphs are kept where they carry meaning (git branch, k8s context, Azure subscription, battery, time). Glyphs are atmosphere AND signal — never strung together as personality garnish.
- Two-track elevation. TUI surfaces are flat (terminals can't render shadow). The mkdocs site is allowed a deeper layered-shadow vocabulary for cards and floating elements — a deliberate divergence so the docs site reads as a polished web artifact, not a terminal screenshot.

## 2. Colors

The palette is two saturated neons (cobalt + magenta) on a three-step pure-black surface ramp, plus seven runtime-channel accents. Names are kept minimal and match `zsh/starship.toml` verbatim — drift between the prompt config and the design spec is the bug.

### Primary

- **cobalt** (`#2D5BFF`): The "where" channel. Directory segments in starship, mkdocs primary fg, ccstatusline working-dir background, nvim `@function` highlight, Azure subscription, line numbers on cursor line are NOT cobalt (they're magenta — see below). The most-used color in the system.
- **cobalt-light** (`#3B82F6`): mkdocs `--md-primary-fg-color--light`, nvim `blue2` for secondary blue surfaces. Used sparingly.
- **cobalt-deep** (`#0050E0`): mkdocs `--md-primary-fg-color--dark`, ccstatusline `frontend-port` background, nvim `blue7`. The recessive cobalt — for tertiary placements that should still read as cobalt.

### Secondary

- **magenta** (`#FF1FE7`): The "what's happening" channel. Git branch + status in starship, error prompt character, hostname over SSH, nvim `@keyword` / `Search` background / `FloatBorder` / `TelescopePromptBorder`, lazygit active pane border, ccstatusline git-branch segment, mkdocs accent + focus border + selection background.
- **magenta-soft** (`#D670D6`): Mid-tier magenta for ccstatusline `git-changes` segment and nvim `magenta2`. The "magenta but lower priority" register.
- **purple** (`#c0a3ff`): Terraform workspace in starship, agents-running segment in ccstatusline, nvim `purple`. Adjacent to magenta; never replaces it.

### Tertiary (runtime channels — never decoration)

- **cyan** (`#22D3EE`): k8s context, golang version, ccstatusline fleet-status, nvim `DiagnosticInfo`. The "cluster-aware" channel.
- **green** (`#22EE99`): Python venv, colima active, vimcmd prompt char, ccstatusline session-cost, nvim `@string`, lazygit `GitSignsAdd`. The "OK / present / live" channel.
- **amber** (`#F59E0B`): cmd_duration (slow command), battery warn, ccstatusline context-percentage, nvim `orange`. The "noteworthy / nearing limit" channel.
- **yellow** (`#F5C542`): nvim `IncSearch` background only. The narrowest-scoped color; specifically for typing-into-search.
- **red** (`#FF4D4D`): Battery critical, lazygit `unstagedChangesColor`, ccstatusline session-usage at high consumption, nvim `red` / `DiagnosticError`. The "stop / block / over-limit" channel.

### Neutral

- **fg** (`#e0e0ee`): Default text. Slightly cool off-white. Used everywhere foreground text needs to read as default — terminal default fg, lazygit `defaultFgColor`, mkdocs `--md-default-fg-color`, ccstatusline ctx-len fg.
- **grey** (`#6b7280`): Prompt frame (`╭─ │ ╰─`), starship time/battery-full, lazygit `inactiveBorderColor`, ccstatusline ctx-len/reset-timer background, mkdocs header bottom-border. The "frame and inactive" color.

### Surface ramp (pure black + tinted elevation)

- **carbon-pure** (`#000000`): Default surface. nvim `bg` / `bg_dark` / `bg_sidebar`, mkdocs `--md-default-bg-color`, terminal background (per terminal-emulator profile). True black is intentional — the cobalt and magenta saturation depends on it.
- **carbon-elevated** (`#0a0a14`): The elevated tier. lazygit `selectedLineBgColor`, mkdocs `--md-default-bg-color--light` + `--md-code-bg-color` + `--md-footer-bg-color`, nvim `bg_float` / `bg_popup` / `bg_statusline`, ccstatusline foreground-on-cobalt and on-magenta (text drawn IN this color over a colored background — it's an inverted use that's the cleanest readable contrast).
- **carbon-active** (`#1a1a3e`): The active/visual tier. nvim `bg_visual` and the `Visual` highlight bg, nvim `CursorLine` is the elevated `#0a0a14` (one step below active). Reserved for "this is what you're acting on right now."
- **linenr-dim** (`#444466`): nvim `LineNr` only. Single-purpose token — quoting it elsewhere drifts the system.

### Named Rules

**The Two-Channel Rule.** Cobalt is *where you are*; magenta is *what's happening*. If a new theme element needs an accent, ask "is this a place or an event?" — and pick accordingly. Never use both colors on the same element to mean different things. Magenta on cobalt and cobalt on magenta are both forbidden — the contrast is illegible.

**The Channel-Earns-Its-Place Rule.** Every non-primary color (cyan, green, amber, yellow, red, purple) is a runtime channel. Yellow is `IncSearch` only; purple is terraform/agents only. A color does not get reused for an unrelated meaning to "add visual variety." If a new state needs a color and none of the existing channels fit, pause — the new state probably belongs on cobalt or magenta.

**The Pure-Black Rule.** The default surface is `#000000`. The cobalt and magenta saturations were calibrated against pure black; adopting `#0a0a14` (or any other near-black) as the default surface dilutes their snap. Reserve `#0a0a14` for elevation, not for the canvas.

**The Starship-Is-Truth Rule.** The 9-color base palette comes from `zsh/starship.toml`. If a value drifts (the bat theme's blue is a slightly different blue, the lazygit accent is one shade off), fix the value in the consuming config — never the other way around. Drift between starship and any other surface is the bug.

## 3. Typography

**Terminal Font:** JetBrainsMono Nerd Font (with `'JetBrains Mono', monospace` fallback) — required for prompt + statusline glyphs. Set in the terminal emulator (cmux / Ghostty / iTerm2) profile.
**Docs Body Font:** Roboto (mkdocs-material default) — kept default; the docs site does not impose a custom body face.
**Docs Mono Font:** Roboto Mono (mkdocs-material default) — kept default; code blocks render in Roboto Mono on the docs site, NOT JetBrainsMono Nerd Font, because Nerd Font glyphs are not material to docs prose.

**Character:** A single mono face carries the entire terminal system — there is no second TUI font. The docs site relies on mkdocs-material's default Roboto pairing without override, which means the only typographic commitment on the site is the use of a sans body and a mono code face. Hierarchy on the site comes from mkdocs-material's built-in scale, recolored to match the palette but otherwise untouched.

### Hierarchy (terminal)

- **Terminal regular** (400, 13px effective at typical terminal-emulator size, line-height 1.4): Default terminal output, prompt body, statusline labels.
- **Terminal bold** (700, 13px): Starship `bold cobalt` and `bold magenta` segments — directory, branch, prompt success/error character, ccstatusline cwd + branch (which use `"bold": true` in JSON).

### Hierarchy (docs site)

- **Docs heading** (600, 32px and below per mkdocs-material scale, line-height 1.2, letter-spacing -0.01em): mkdocs-material default scale, untouched. Headings inherit the Roboto sans default.
- **Docs body** (400, 16px, line-height 1.6): Default mkdocs-material body type. Untouched.
- **Docs mono** (400, 14px, line-height 1.5): Code blocks and inline `<code>` on the docs site. mkdocs-material default, with the cobalt 30% border and `carbon-elevated` background applied via `docs/stylesheets/cobalt.css`.

### Named Rules

**The Mono-Is-The-Voice Rule.** The terminal system has exactly one typographic register — JetBrainsMono Nerd Font. Hierarchy comes from weight (regular vs. bold), color, and Nerd Font glyph density, not from a typographic scale. The terminal does not have headings.

**The Docs-Inherit Rule.** The mkdocs site uses mkdocs-material's typography defaults. Custom typography on the docs site is forbidden unless the change cascades from the palette (color, link decoration). Adding a custom font face or a custom scale converts the site from "documented system" to "second design system" — bad.

**The Glyph-Is-Signal Rule.** Nerd Font glyphs (`󰠅` for Azure, `⎈` for k8s, `󰁹` for battery, ` ` for git, etc.) are kept where they carry meaning. Stringing glyphs together to "add personality" — the powerline arrows-of-arrows trap — is forbidden. Each glyph either replaces a label or makes a label faster to scan.

## 4. Elevation

The system has a deliberate split: TUI surfaces are flat (terminals can't render shadow); the mkdocs site is allowed a deeper, layered shadow vocabulary so the docs read as a polished web artifact rather than a screenshot of a terminal.

### TUI elevation (flat by physics)

Three-step surface ramp does the work that shadow does in CSS systems:

- `carbon-pure` (`#000000`) — default canvas
- `carbon-elevated` (`#0a0a14`) — code blocks, statusline backgrounds, lazygit selection, nvim float background
- `carbon-active` (`#1a1a3e`) — nvim Visual / CursorLine, "what you're acting on right now"

Plus 1-px borders for focus (nvim Telescope, lazygit active pane, ccstatusline powerline edges where the next segment is empty).

### Docs-site elevation (layered)

The mkdocs site can use a layered shadow vocabulary for cards, floating elements, and admonition lifts. The shadows below are reserved for the docs site only — TUI surfaces have no shadow at all.

### Shadow Vocabulary (docs site)

- **shadow-low** (`box-shadow: 0 1px 2px rgba(0, 0, 0, 0.6)`): Subtle depth on inline cards, admonition lifts. Used at rest.
- **shadow-med** (`box-shadow: 0 8px 24px -8px rgba(0, 0, 0, 0.7)`): Hover lift on cards in the palette / prompt walkthrough pages. Adds a sense of "you're acting on this."
- **shadow-magenta-glow** (`box-shadow: 0 0 0 1px #FF1FE7, 0 0 16px rgba(255, 31, 231, 0.35)`): Reserved for focused inputs and the active tab on the docs site. The 1-px magenta ring is a structural focus indicator; the 16-px glow is the synthwave atmosphere. Forbidden on cards or large surfaces — the glow loses meaning at scale.
- **shadow-cobalt-pop** (`box-shadow: 0 0 12px rgba(45, 91, 255, 0.4)`): Reserved for the docs-site's hero or feature image (the palette swatch grid, the prompt screenshot). Atmospheric only, not interactive.

### Named Rules

**The TUI-Has-No-Shadow Rule.** Terminal surfaces (nvim, tmux, lazygit, bat, ccstatusline, starship) cannot and must not pursue shadow. Hierarchy in the terminal comes from the surface ramp, color contrast, and 1-px borders. Pretending a TUI can have shadow is a category error.

**The Magenta-Glow-Is-Focus Rule.** On the docs site, `shadow-magenta-glow` is reserved for the focused input, the active tab, and any element that represents "the thing the user is interacting with right now." It does not appear at rest, on hover for ordinary cards, or as decoration. The glow signals interactivity, not atmosphere.

**The Cobalt-Pop-Is-Showpiece Rule.** `shadow-cobalt-pop` appears at most once or twice per docs page — on the hero palette swatch or the most-prominent before/after screenshot. Every additional use erodes its rarity.

## 5. Components

### Starship Prompt Segments

The 3-line starship prompt (`╭─ dir + git`, `│ k8s + azure + python + cmd_duration`, `╰─ character`) plus right-side `battery + time` is the primary identity surface. Each segment is a colored token over the terminal background.

- **Directory segment**: `[ $path ]` rendered as `bold cobalt`. Truncates at 4 components with `…/` symbol; `~/Documents/GitHub` substitutes to ` gh`, `~/work` to ` work`, `~/Code` to ` code`.
- **Git branch segment**: ` $branch` rendered as `magenta`. Triggered by repo presence.
- **Git status segment**: All-status counters (`!`, `+`, `?`, `✘`, etc.) plus ahead/behind in `magenta`.
- **Prompt character**: `❯` in `bold cobalt` on success; `✗ ❯` in `bold magenta` on failure (last command exited non-zero); `❮` in `bold green` in vim normal mode.
- **Frame separators**: `╭─`, `│`, `╰─` rendered in `grey`. Three-line frame is the prompt's structural signature.
- **Right-side battery + time**: Battery percentage with `󰁹` (full) / `󰂄` (charging) / `󰂃` (discharging) glyph; color shifts `red` < 20% < `amber` < 50% < `grey`. Time `%H:%M` in `grey`.
- **Contextual segments** (only render when relevant): k8s `⎈ context` in `cyan`; Azure `󰠅 subscription` in `bold cobalt`; Python ` version (venv)` in `green`; terraform `󱁢 workspace` in `purple`; nodejs ` version` in `green`; golang ` version` in `cyan`; colima `🐳` in `bold green` when the docker socket exists.

### ccstatusline Segments (Claude Code statusline, powerline-themed)

A multi-line powerline statusline with three rows. Each segment is a solid block of background color with foreground text rendered in `carbon-elevated` (`#0a0a14`) for cobalt/magenta/amber/green/cyan/purple backgrounds; rendered in `fg` (`#e0e0ee`) for the cobalt-deep `frontend-port` block and the grey ctx-length blocks.

- **Row 1**: model (cobalt bg, bold) → thinking-effort (magenta bg) → context-length (grey bg) → context-percentage (amber bg) → session-usage (red bg) → reset-timer (grey bg) → session-cost (green bg) → fleet-status (cyan bg, custom-command).
- **Row 2**: cwd (cobalt bg, bold, 3 segments, abbreviateHome) → git-branch (magenta bg, bold) → git-changes (magenta-soft bg) → acc-health (green bg) → frontend-port (cobalt-deep bg).
- **Row 3**: agents-running (purple bg).
- **Separator**: powerline arrow ``. Color inheritance is on (`continueThemeAcrossLines: true`); separator inverts background per segment.

### lazygit Theme

- **Active pane border**: `magenta` (`#FF1FE7`), bold. The visual cue for "this is the focused pane."
- **Inactive pane border**: `grey` (`#6b7280`).
- **Selected line background**: `carbon-elevated` (`#0a0a14`) — one step up from the canvas.
- **Cherry-picked commit**: `magenta` background, `#000000` foreground. Reserved for the cherry-pick mode.
- **Unstaged changes color**: `red` (`#FF4D4D`).
- **Default fg**: `fg` (`#e0e0ee`).
- **Options text color**: `cobalt` (`#2D5BFF`).
- **Nerd Fonts version 3** with icons enabled. File tree shown; command log hidden by default.

### nvim (TokyoNight Storm, customized)

The colorscheme overrides TokyoNight Storm's defaults to enforce pure-black surfaces and the cobalt+magenta accent set.

- **Surfaces**: `bg = bg_dark = bg_sidebar = #000000`; `bg_float = bg_popup = bg_statusline = #0a0a14`; `bg_visual = #1a1a3e`.
- **Float / Telescope border**: `magenta` foreground on `bg_float` background. The "this is a focused floating window" signature.
- **Cursor line number**: `magenta` bold.
- **Cursor line background**: `#0a0a14`.
- **Search highlight**: `magenta` background, `#000000` foreground, bold.
- **IncSearch (typing-in-search)**: `yellow` background, `#000000` foreground, bold. The narrowest-scoped color in the system.
- **Visual selection**: `#1a1a3e` background.
- **Keyword + function syntax**: `magenta` (keywords, bold) + `cobalt` (functions, bold). Strings are `green`. Types are `cyan`.
- **Diagnostics**: error `red`, warn `amber`, info `cyan`, hint `magenta`.
- **Git signs**: add `green`, change `cobalt`, delete `red`.

### bat

Set to `TwoDark` theme — "the closest built-in to the cobalt/magenta-on-black aesthetic" (per `bat/config` comment). Style flags: `numbers,changes,header`. Paging on auto. The bat theme is the one TUI surface where the palette is *approximated* rather than *enforced* (a custom-built bat theme would be a future extension; for now TwoDark is the documented best-fit).

### mkdocs-material Customizations (`docs/stylesheets/cobalt.css`)

- **Primary fg color** (`--md-primary-fg-color`): `cobalt`. With `--light: cobalt-light` and `--dark: cobalt-deep`.
- **Accent fg color** (`--md-accent-fg-color`): `magenta`. With `--transparent: rgba(255, 31, 231, 0.1)` for backgrounds.
- **Default bg / fg**: `carbon-pure` background (pure black), `fg` foreground.
- **Code block**: `carbon-elevated` background, `fg` foreground, 1-px cobalt border at 30% alpha.
- **Footer**: `carbon-elevated` background.
- **Link**: `cobalt` text. Hover → `magenta` text + wavy underline in `magenta`.
- **Search input + active tab**: `magenta` border-bottom on focus.
- **Admonition default**: cobalt left border. Warning admonition: magenta left border. (Note: this uses `border-left-color` only, not a side-stripe — it inherits the mkdocs-material structural border.)
- **Selection** (`::selection`): `magenta` background, `carbon-pure` foreground. The most aggressive element on the site, reserved for "you literally selected text."
- **Header**: `carbon-elevated` background, `grey` 1-px bottom border.

## 6. Do's and Don'ts

### Do:
- **Do** treat `zsh/starship.toml`'s `[palettes.cobalt]` block as the source of truth for the 9 base color values. If the mkdocs CSS, lazygit config, ccstatusline JSON, or nvim colorscheme drifts from those values, fix the consuming config.
- **Do** keep cobalt and magenta on `carbon-pure` (`#000000`) surfaces only. Saturation was calibrated against pure black; near-black tints dilute it.
- **Do** use cobalt for *where you are* (directory, working dir, model name, k8s context-as-token, Azure subscription) and magenta for *what's happening* (git state, command failure, focused element, active tab, selection).
- **Do** keep the 3-line starship prompt frame (`╭─ │ ╰─`) in `grey`. The frame is structural, not accent.
- **Do** allow the docs site to use shadows (low / med / magenta-glow / cobalt-pop) as documented. The site is allowed depth that the TUI cannot have.
- **Do** keep mkdocs-material's typography defaults (Roboto + Roboto Mono). Adding a custom font on the site converts it from "documented system" to "second design system."
- **Do** treat each Nerd Font glyph as signal — `⎈` means k8s, `󰠅` means Azure, `` means git, `󰁹` means battery. If a glyph doesn't replace a label or make scanning faster, drop it.
- **Do** preserve `prefers-reduced-motion` on the docs site — no scroll-driven animations.
- **Do** check that `JetBrainsMono Nerd Font` is brewed and active before assuming glyphs render; gracefully fall back to ASCII when it's missing (per starship config behavior).
- **Do** keep the `"bold": true` flags on the cobalt and magenta starship/ccstatusline segments. The bold weight is half the visual identity.

### Don't:
- **Don't** use a Dracula or Catppuccin palette. The cobalt + magenta combination is the differentiator; defaulting to a popular package is failure (PRODUCT.md anti-reference).
- **Don't** use a corporate / VSCode-default blue-gray palette. Microsoft Cascadia, default macOS Terminal, generic enterprise dev-tool aesthetics are all under-committed (PRODUCT.md anti-reference).
- **Don't** put cobalt on magenta or magenta on cobalt. The contrast is illegible.
- **Don't** put cobalt or magenta on a light surface (white, beige, cream). The saturation dies.
- **Don't** use box-shadow in any TUI surface (nvim, tmux, lazygit, bat, ccstatusline, starship). Terminals can't render shadow; pretending they can is a category error.
- **Don't** use `shadow-magenta-glow` on cards or large surfaces. It signals interactivity at element scale; at surface scale it becomes decoration.
- **Don't** use `border-left` greater than 1-px on the docs site as a colored stripe. mkdocs-material's admonition uses a structural left border that's part of the chassis — overriding it with a thicker colored stripe is the impeccable "side-stripe" anti-pattern.
- **Don't** drift the bat theme away from TwoDark without building a custom bat theme that matches the palette exactly. An approximation that's "close to cobalt+magenta" is worse than the documented TwoDark approximation.
- **Don't** add a third typeface to the system. The terminal uses JetBrainsMono Nerd Font. The docs site uses mkdocs-material defaults (Roboto + Roboto Mono). That's the entire typographic vocabulary.
- **Don't** chain Nerd Font glyphs together as personality garnish. Each glyph either replaces a label or makes scanning faster. "Personality" glyphs dilute the signal.
- **Don't** use yellow (`#F5C542`) outside of nvim's `IncSearch`. It's a single-purpose token; quoting it elsewhere drifts the system.
- **Don't** use em dashes in prose on the docs site. Use commas, colons, semicolons, periods, or parentheses. Also not `--` (cross-cutting impeccable rule).
- **Don't** use color alone to convey meaning. The git-dirty marker is also a glyph; the failure prompt is also a character change (`❯` → `✗ ❯`); the battery state is also a percentage.
- **Don't** hard-code `/Users/jay` paths in any public surface (configs, docs, install.sh). Use `~` or `${HOME}` (per PRODUCT.md design principle 5).
