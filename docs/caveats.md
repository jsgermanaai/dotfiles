# ⚠️ Caveats & gotchas

??? warning "The Brewfile is a fresh-machine spec, not an inventory."
    If you `brew install <thing>` manually for a one-off, it won't be in the
    Brewfile. That's by design — the file describes what a **new** laptop
    should bootstrap with, not a snapshot of every binary you've ever touched.
    Don't run `brew bundle cleanup --force` against it.

??? warning "Terminal font has to be set in the terminal app's UI."
    JetBrainsMono Nerd Font is brewed but you must point your terminal at it.
    The starship prompt and tmux statusline use Nerd Font glyphs; without them
    you'll see boxes and `?` characters.

??? warning "The MLX server doesn't start automatically."
    This is intentional — your laptop's RAM thanks you. Run `mlx-start` when
    you want AI; the nvim plugin will fail with a connection error until then.
    Use `ai-status` to confirm reachability.

??? warning "Colima also doesn't start automatically."
    Same reason — keeps RAM free when you don't need Docker. The 🐳 in the
    starship prompt tells you it's running.

??? warning "Headless Mason install can occasionally race."
    If you saw a Mason error during `install.sh`, just open `nvim` and run
    `:Mason` — it'll pick up wherever it left off.

??? warning "The fzf installer modifies `~/.zshrc` directly on first run."
    Because `~/.zshrc` is a symlink into the dotfiles repo, the modification
    lands in source. The current `.zshrc` already contains the line it would
    add, so it's a no-op on subsequent runs. If you ever see double-source
    lines, dedupe in the source file.

??? warning "README screenshots use ASCII fallbacks for Nerd Font glyphs."
    `charmbracelet/freeze` (the screenshot generator) can't resolve the
    JetBrainsMono Nerd Font name, so synthesised prompt shots use
    `(dir)`/`[k8s]`/`[bat]`-style placeholders. Your real terminal renders the
    actual glyphs (` `, `⎈`, `󰁹`). Regenerate with
    `./docs/screenshots/generate.sh`.
