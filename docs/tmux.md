# 🪟 Tmux

Cobalt-and-magenta-on-black status bar. Prefix is ++ctrl+a++. Sessions auto-resurrect on boot via `tmux-continuum`.

![tmux session](screenshots/tmux.png)

## Top keybindings

| Keys | Action |
|------|--------|
| ++ctrl+a++ ++pipe++ | Split pane vertically (in current dir) |
| ++ctrl+a++ ++minus++ | Split pane horizontally |
| ++alt+left++ / ++alt+right++ / ++alt+up++ / ++alt+down++ | Move between panes (no prefix) |
| ++shift+left++ / ++shift+right++ | Switch windows (no prefix) |
| ++ctrl+a++ ++"r"++ | Reload `.tmux.conf` |
| ++ctrl+a++ ++shift+"i"++ | Install plugins (TPM) |
| ++ctrl+a++ ++"["++ | Enter copy mode → ++"v"++ select, ++"y"++ yank to clipboard |

See `~/.tmux-cheatsheet.md` for the full list.
