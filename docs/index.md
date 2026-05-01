# 🌃 dotfiles

A neon-cobalt + magenta development environment for macOS.
Reproducible from one script. Themed end-to-end across **nvim, tmux, starship, lazygit, fzf, and bat**.

![Cobalt + Magenta palette](screenshots/palette.png){ width=700 }

!!! tip "TL;DR"
    ```bash
    git clone <this-repo> ~/.dotfiles
    cd ~/.dotfiles
    ./install.sh
    ```

## What's inside

=== "🧰 Tools"

    - 🐚 **zsh** + oh-my-zsh + starship
    - ⚡ **fzf** + fzf-tab + zsh-autosuggestions
    - 🪟 **tmux** w/ TPM (sessions auto-restore)
    - 📝 **Neovim** (LazyVim) — Go, K8s/YAML, Docker, AI
    - 🐙 **lazygit** — TUI git client
    - 🤖 **CodeCompanion** — local AI via MLX or LM Studio
    - 🐳 **Colima** — on-demand Docker/k8s VM with prompt indicator

=== "🦾 Modern CLI replacements"

    | Old | New | Alias |
    |-----|-----|-------|
    | `ls` | eza | `ls`, `ll`, `lt` |
    | `cat` | bat | `bcat` |
    | `grep` | ripgrep | `rg` |
    | `find` | fd | `fd` |
    | `cd` | zoxide | `j foo` |
    | `git diff` | delta | (auto) |
    | `top` | btop | `btop` |
    | `du` | dust | `dust` |
    | `man` | tldr | `tldr` |

## Where to next

- [Install →](install.md) — what `./install.sh` actually does
- [Prompt →](prompt.md) — every starship segment, how to enable/disable each
- [Colima →](colima.md) — on-demand Docker/k8s with a 🐳 prompt indicator
- [Local AI →](ai.md) — Gemma 3 over MLX or LM Studio in nvim
