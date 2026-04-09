# dotfiles

Personal development environment for macOS.

## What's included

| Directory | Contents |
|-----------|----------|
| `zsh/` | Shell config (oh-my-zsh, aliases, PATH, functions) |
| `git/` | Git config with conventional commit aliases and multi-account support |
| `tmux/` | tmux config (Catppuccin theme, TPM plugins, vim-style navigation) |
| `vim/` | Vim runtime loader |
| `nvim/` | LazyVim config (Go, K8s/YAML, Docker, productivity plugins) |
| `ssh/` | SSH config structure (multi-account GitHub) |
| `scripts/` | Dev session launcher and utilities |
| `Brewfile` | Homebrew formulae and casks |
| `macos.sh` | macOS system defaults |

## Quick start

```bash
git clone git@github.com:<your-user>/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The install script will:
1. Symlink all dotfiles to their correct locations
2. Install Homebrew (if missing)
3. Install packages from the Brewfile
4. Install oh-my-zsh (if missing)
5. Install tmux plugin manager (if missing)

## Secrets

Machine-specific secrets go in `~/.zshrc.local` (gitignored). The `.zshrc` sources it automatically.

```bash
# ~/.zshrc.local (example)
export GEMINI_API_KEY="..."
export LINEAR_API_KEY="..."
```

## Multi-account Git

Uses `includeIf` for directory-based identity switching:
- `~/work/` and `~/Code/k8s-rbac-audit-toolkit/` use the AuditIdentity config
- Everything else uses the default (personal) config

## Dependencies

- macOS (Apple Silicon)
- [Homebrew](https://brew.sh)
- [oh-my-zsh](https://ohmyz.sh)
- [TPM](https://github.com/tmux-plugins/tpm) (tmux plugin manager)
- [LazyVim](https://www.lazyvim.org)
- Nerd Font (Hack or JetBrains Mono)
