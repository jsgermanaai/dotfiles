# 🚀 Install

```bash
git clone <this-repo> ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

Then in your terminal (cmux/Ghostty/iTerm2):

1. Set the font to **JetBrainsMono Nerd Font** (already brewed)
2. `exec zsh` to pick up the new prompt
3. Drop secrets in `~/.zshrc.local`

## Flags

| Flag | Effect |
|------|--------|
| (none) | Install + configure everything |
| `--no-headless` | Skip headless tmux/nvim plugin installs (CI-safe) |
| `--cleanup-preview` | Show what's installed but NOT in the Brewfile (read-only) |
| `--help` | Help |

`DOTFILES=/custom/path ./install.sh` lets you keep the repo somewhere other than `~/.dotfiles`.

## What it does, end-to-end

1. Symlinks all 13 config files
2. Bridges `~/.dotfiles → $DOTFILES` if you cloned somewhere else
3. Installs **Homebrew** if missing → runs `brew bundle`
4. Installs **oh-my-zsh** + 3 custom plugins
5. Installs **fzf shell bindings** (`Ctrl-R`/`Ctrl-T`/`Alt-C`)
6. Warms the **tealdeer** cache
7. Installs **TPM** + headless-installs all 8 tmux plugins
8. Installs **amix vim runtime**
9. **Headless `:Lazy sync`** — installs every LazyVim plugin
10. **Headless `:MasonInstall`** — installs all configured LSPs/formatters
11. Installs **NVM**
12. Installs **mlx-lm** via pipx for local AI
13. **Verifies** all 21 critical tools resolve

!!! warning "There's no `--cleanup --force`"
    `brew bundle cleanup --force` is intentionally *not* available from the
    install script — the Brewfile is your fresh-machine spec, not an
    inventory. Cleanup would uninstall manually-added tools (cmux, claude-code,
    personal taps). Use `--cleanup-preview` to see what's untracked, then
    `brew uninstall <name>` selectively.
