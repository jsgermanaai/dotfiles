# 🎨 Color palette

The same palette is shared across **terminal, tmux, starship, fzf, nvim, lazygit, and bat** so context-switching never breaks visual flow.

![Palette](screenshots/palette.png){ width=700 }

| Role | Hex | Usage |
|------|-----|-------|
| Background | `#000000` | terminal, panels, status bar |
| Surface | `#0a0a14` | floats, raised UI |
| Foreground | `#e0e0ee` | primary text |
| **Cobalt** *(primary)* | `#2D5BFF` | dirs, prompts, keywords, status |
| **Magenta** *(accent)* | `#FF1FE7` | git, errors, search, active borders |
| Grey | `#6b7280` | inactive chrome, separators |
| Cyan | `#22D3EE` | k8s, info diagnostics |
| Amber | `#F59E0B` | cmd duration, warnings |
| Green | `#22EE99` | success, additions |
| Red | `#FF4D4D` | failure, deletions |

## Where each colour is defined

| Surface | File | Notes |
|---------|------|-------|
| Starship prompt | [`zsh/starship.toml`](https://github.com/your-user/dotfiles/blob/main/zsh/starship.toml) | `[palettes.cobalt]` block |
| fzf | [`zsh/.zshrc`](https://github.com/your-user/dotfiles/blob/main/zsh/.zshrc) | `$FZF_DEFAULT_OPTS` |
| Neovim | [`nvim/lua/plugins/colorscheme.lua`](https://github.com/your-user/dotfiles/blob/main/nvim/lua/plugins/colorscheme.lua) | `on_colors` and `on_highlights` overrides |
| Tmux | [`tmux/.tmux.conf`](https://github.com/your-user/dotfiles/blob/main/tmux/.tmux.conf) | status/window/pane styles |
| Lazygit | [`lazygit/config.yml`](https://github.com/your-user/dotfiles/blob/main/lazygit/config.yml) | `gui.theme` block |
| Bat | uses `TwoDark` (closest built-in match) | Set in `bat/config` |
