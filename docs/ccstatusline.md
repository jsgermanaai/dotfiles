# 🛰️ ccstatusline — Claude Code prompt

A 3-line powerline status line for [Claude Code](https://docs.claude.com/en/docs/claude-code/), themed with the same cobalt + magenta palette as starship and tokyonight.
Every segment is a coloured pill with chevron separators; backgrounds carry the semantic role, so a glance tells you cost, context, and git state without reading text.

## How it loads

Claude Code calls whatever command is set under `statusLine` in `~/.claude/settings.json`:

```json
"statusLine": {
  "type": "command",
  "command": "npx -y ccstatusline@latest",
  "padding": 0
}
```

[`ccstatusline`](https://github.com/sirmalloc/ccstatusline) (npm package by sirmalloc) reads its layout from `~/.config/ccstatusline/settings.json`, which `install.sh` symlinks to [`ccstatusline/settings.json`](https://github.com/jsgermanaai/dotfiles/blob/main/ccstatusline/settings.json) in this repo.

## Anatomy

```text
# Line 1 — telemetry
 Sonnet 4.6   Thinking: high   Ctx: 12.3k   Ctx Used: 6%   Session: 18%   Reset: 4hr 12m   Cost: $0.42   fleet: 0/3
   │              │              │             │              │             │              │            │
   │              │              │             │              │             │              │            └─ fleet probe (running agents)
   │              │              │             │              │             │              └─ session cost (USD)
   │              │              │             │              │             └─ minutes until usage window resets
   │              │              │             │              └─ % of weekly usage budget consumed
   │              │              │             └─ % of model context window consumed
   │              │              └─ raw token count of context
   │              └─ thinking-effort (off / default / hard / max)
   └─ active model

# Line 2 — workspace
 …/Code/flagship-system   ⎇ chore/wrap-2026-04-30   (+12,-3)   acc: ok   web: 5173
       │                          │                 │            │         │
       │                          │                 │            │         └─ frontend dev-server probe
       │                          │                 │            └─ acc-health probe
       │                          │                 └─ git changes (+added,-deleted)
       │                          └─ git branch
       └─ cwd, last 3 segments, $HOME abbreviated to ~

# Line 3 — agents
 agents: 2 running
   └─ background-agent probe (Forge, Atlas, Pipeline, …)
```

## Palette mapping

ccstatusline uses **truecolor** (`colorLevel: 3`) and the `"custom"` powerline theme so each widget owns its `backgroundColor`. Roles mirror starship 1:1.

| Widget | Background | Foreground | Role mirror |
|--------|------------|------------|-------------|
| `model`, `cwd` | cobalt `#2D5BFF` (bold) | `#0a0a14` | starship `directory` — primary identity |
| `thinking-effort`, `git-branch` | magenta `#FF1FE7` (bold) | `#0a0a14` | starship `git_branch` — accent |
| `git-changes` | magenta2 `#D670D6` | `#0a0a14` | git family, softer than branch |
| `context-percentage` | amber `#F59E0B` | `#0a0a14` | starship `cmd_duration` — caution scale |
| `session-usage` | red `#FF4D4D` | `#0a0a14` | starship `battery` low — cost alarm |
| `session-cost` | green `#22EE99` | `#0a0a14` | starship `python` — positive |
| `fleet`, _other secondary info_ | cyan `#22D3EE` | `#0a0a14` | starship `kubernetes` |
| `frontend-port` | deep cobalt `#0050E0` | `#e0e0ee` | tokyonight `blue7` — dev-server tied to primary |
| `agents-running` | purple `#c0a3ff` | `#0a0a14` | starship `terraform` — orchestration |
| `context-length`, `reset-timer` | grey `#6b7280` | `#e0e0ee` | starship frame `grey` — dim utility |

## Custom probes

Three of the segments shell out to scripts in `~/.claude/statusline-probes/`:

| Segment | Script | What it shows |
|---------|--------|---------------|
| `c-fleet` | `fleet-status.sh` | running background agents |
| `l-acc` | `acc-health.sh` | health of the local acc service |
| `l-frontend` | `frontend-port.sh` | dev-server port if running |
| `l-agents` | `agents-running.sh` | live agent count |

These probes live in `~/.claude/`, **outside this repo** — they're machine-specific. The settings.json references them by absolute path; copy them to a new machine separately.

## Editing

Because `~/.config/ccstatusline/settings.json` is a symlink into this repo, any edit you make is instantly under version control:

```bash
$EDITOR ~/.config/ccstatusline/settings.json   # edits the file in this repo
cd ~/dotfiles && git diff ccstatusline/        # review
```

## Hex format gotcha

ccstatusline parses colours as `"hex:RRGGBB"` — **no `#`, no leading `0x`, exactly 6 hex digits**. Anything else is silently dropped (returns empty ANSI escape). And `colorLevel` must be `3` for hex to be honoured at all; `2` (256-colour) ignores hex strings. The package's `getColorAnsiCode` source confirms both behaviours.

## Reset

If you want to start over from the package default:

```bash
rm ~/.config/ccstatusline/settings.json
npx -y ccstatusline@latest        # interactive TUI walks you through the default layout
```

…and then re-symlink back here once you've copied the chosen settings into `ccstatusline/settings.json`.
