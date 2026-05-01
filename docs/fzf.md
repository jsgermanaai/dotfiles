# ⚡ fzf shortcuts

| Keybinding | What it does |
|-----------|--------------|
| ++ctrl+r++ | Fuzzy search shell history |
| ++ctrl+t++ | Fuzzy file picker (uses `fd`) — inserts paths into the current command |
| ++alt+c++  | Fuzzy `cd` into a subdirectory |
| ++tab++    | **fzf-tab** replaces zsh's tab completion with an fzf menu |

## Theme

The fzf colour scheme is set in `~/.zshrc` via `$FZF_DEFAULT_OPTS` and matches
the rest of the cobalt + magenta palette — pointer, header, selection, and
border all in cobalt/magenta on pure black.

```bash
export FZF_DEFAULT_OPTS="
  --height 40% --layout=reverse --border=rounded
  --color=bg+:#0a0a14,bg:#000000,spinner:#FF1FE7,hl:#FF1FE7
  --color=fg:#e0e0ee,header:#FF1FE7,info:#22D3EE,pointer:#FF1FE7
  --color=marker:#22EE99,fg+:#FF1FE7,prompt:#2D5BFF,hl+:#FF1FE7
  --color=border:#2D5BFF"
```

## fzf-tab tuning

```zsh
zstyle ':completion:*' menu no
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always --icons $realpath'
```

This makes `cd <Tab>` and `j <Tab>` show an eza preview of the highlighted directory.
