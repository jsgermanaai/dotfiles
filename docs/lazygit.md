# 🐙 Lazygit

A fast TUI for git. Theme is palette-matched (cobalt/magenta on black).

![lazygit on dotfiles repo](screenshots/lazygit.png)

## Launch

| Where | How |
|-------|-----|
| Shell | `lg` (alias) or `lazygit` |
| Inside nvim | ++leader+"g"+"g"++ (toggleterm float) |

## Diff pager

Lazygit's diff view uses **delta** under the hood (configured in `lazygit/config.yml`),
so diffs there look identical to `git diff` on the command line.
