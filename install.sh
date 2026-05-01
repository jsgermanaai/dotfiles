#!/usr/bin/env bash
# One-shot dotfiles installer.
#   ./install.sh                       install + configure everything
#   ./install.sh --no-headless         skip headless tmux/nvim plugin installs (CI-safe)
#   ./install.sh --cleanup-preview     show what `brew bundle cleanup` WOULD remove
#                                      (read-only — never deletes anything)
#   DOTFILES=/custom/path ./install.sh use a different repo location
#
# NOTE: there is intentionally no `--cleanup --force` switch. The Brewfile is the
# fresh-machine spec, not a complete inventory — running `brew bundle cleanup --force`
# would uninstall manually-installed tools (terminals, taps, dev utilities).
# If you really mean to remove unlisted formulae, do it by hand: `brew uninstall <name>`.
set -euo pipefail

# ─── Args ────────────────────────────────────────────────────────
DO_CLEANUP_PREVIEW=0
DO_HEADLESS=1
for arg in "$@"; do
    case "$arg" in
        --cleanup-preview) DO_CLEANUP_PREVIEW=1 ;;
        --no-headless)     DO_HEADLESS=0 ;;
        -h|--help)
            sed -n '2,12p' "$0" | sed 's/^# *//'
            exit 0
            ;;
        *) echo "Unknown arg: $arg" >&2; exit 2 ;;
    esac
done

# ─── Resolve repo location ──────────────────────────────────────
# Default to ~/.dotfiles. If $DOTFILES is overridden, honor it.
# Either way, ensure ~/.dotfiles exists (as dir or symlink) so anything
# that hardcoded ~/.dotfiles still resolves.
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

# If the override points elsewhere and ~/.dotfiles is missing, bridge it.
if [ ! -e "$HOME/.dotfiles" ] && [ "$DOTFILES" != "$HOME/.dotfiles" ]; then
    ln -s "$DOTFILES" "$HOME/.dotfiles"
fi

info()  { printf "\033[1;34m[info]\033[0m  %s\n" "$1"; }
ok()    { printf "\033[1;32m[ok]\033[0m    %s\n" "$1"; }
warn()  { printf "\033[1;33m[warn]\033[0m  %s\n" "$1"; }
fail()  { printf "\033[1;31m[fail]\033[0m  %s\n" "$1"; }
section() { printf "\n\033[1;35m━━ %s ━━\033[0m\n" "$1"; }

# ─── Symlink helper ───────────────────────────────────────────────
link_file() {
    local src="$1" dst="$2"
    if [ -L "$dst" ]; then
        rm "$dst"
    elif [ -f "$dst" ] || [ -d "$dst" ]; then
        warn "Backing up existing $dst → ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    ok "Linked $dst → $src"
}

# ─── Symlinks ────────────────────────────────────────────────────
section "Linking dotfiles"
link_file "$DOTFILES/zsh/.zshrc"                   "$HOME/.zshrc"
link_file "$DOTFILES/zsh/.zprofile"                "$HOME/.zprofile"
link_file "$DOTFILES/zsh/starship.toml"            "$HOME/.config/starship.toml"
link_file "$DOTFILES/ccstatusline/settings.json"   "$HOME/.config/ccstatusline/settings.json"
link_file "$DOTFILES/git/.gitconfig"               "$HOME/.gitconfig"
link_file "$DOTFILES/git/.gitconfig-auditidentity" "$HOME/.gitconfig-auditidentity"
link_file "$DOTFILES/tmux/.tmux.conf"              "$HOME/.tmux.conf"
link_file "$DOTFILES/tmux/.tmux-cheatsheet.md"     "$HOME/.tmux-cheatsheet.md"
link_file "$DOTFILES/vim/.vimrc"                   "$HOME/.vimrc"
link_file "$DOTFILES/nvim"                         "$HOME/.config/nvim"
link_file "$DOTFILES/lazygit/config.yml"           "$HOME/.config/lazygit/config.yml"
link_file "$DOTFILES/bat/config"                   "$HOME/.config/bat/config"
link_file "$DOTFILES/scripts/setup-dev-session.sh" "$HOME/.setup-dev-session.sh"

mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
link_file "$DOTFILES/ssh/config" "$HOME/.ssh/config"

# ─── Homebrew + Brewfile ─────────────────────────────────────────
section "Homebrew"
if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    ok "Homebrew already installed"
fi

if [ -f "$DOTFILES/Brewfile" ]; then
    info "Installing Homebrew packages (this can take a while on a fresh machine)..."
    brew bundle --file="$DOTFILES/Brewfile"
fi

if [ "$DO_CLEANUP_PREVIEW" -eq 1 ]; then
    section "Cleanup preview (read-only)"
    warn "The Brewfile is your FRESH-MACHINE spec, not an inventory of everything you have."
    warn "Anything below is installed locally but not in the Brewfile."
    warn "DO NOT blindly run 'brew bundle cleanup --force' — read first, then uninstall by hand."
    brew bundle cleanup --file="$DOTFILES/Brewfile" || true
fi

# ─── oh-my-zsh + custom plugins ─────────────────────────────────
section "Zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    ok "oh-my-zsh already installed"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
clone_plugin() {
    local name="$1" url="$2"
    if [ ! -d "$ZSH_CUSTOM/plugins/$name" ]; then
        info "Cloning $name..."
        git clone --depth=1 "$url" "$ZSH_CUSTOM/plugins/$name"
    else
        ok "$name already installed"
    fi
}
clone_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
clone_plugin zsh-autosuggestions     https://github.com/zsh-users/zsh-autosuggestions.git
clone_plugin fzf-tab                 https://github.com/Aloxaf/fzf-tab.git

# ─── fzf shell keybindings ──────────────────────────────────────
if command -v fzf &>/dev/null; then
    FZF_PREFIX="$(brew --prefix)/opt/fzf"
    if [ -x "$FZF_PREFIX/install" ] && [ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.zsh" ]; then
        info "Installing fzf shell keybindings (Ctrl-R / Ctrl-T / Alt-C)..."
        "$FZF_PREFIX/install" --all --no-bash --no-fish --xdg --no-update-rc
    else
        ok "fzf shell keybindings already present"
    fi
fi

# ─── tldr cache ─────────────────────────────────────────────────
if command -v tldr &>/dev/null; then
    info "Warming tldr cache..."
    tldr --update >/dev/null 2>&1 || warn "tldr cache update failed (run 'tldr --update' later)"
fi

# ─── TPM (tmux plugin manager) + plugins ───────────────────────
section "Tmux"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    info "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
    ok "TPM already installed"
fi

if [ "$DO_HEADLESS" -eq 1 ] && command -v tmux &>/dev/null; then
    info "Installing tmux plugins (headless via TPM)..."
    "$HOME/.tmux/plugins/tpm/bin/install_plugins" >/dev/null 2>&1 \
        && ok "Tmux plugins installed" \
        || warn "TPM headless install failed — run 'prefix + I' inside tmux later"
fi

# ─── Vim (amix runtime) ─────────────────────────────────────────
section "Vim"
if [ ! -d "$HOME/.vim_runtime" ]; then
    info "Installing amix/vimrc..."
    git clone --depth=1 https://github.com/amix/vimrc.git "$HOME/.vim_runtime"
    sh "$HOME/.vim_runtime/install_awesome_vimrc.sh"
else
    ok "vim_runtime already installed"
fi

# ─── Neovim plugin sync (LazyVim) ──────────────────────────────
section "Neovim"
if [ "$DO_HEADLESS" -eq 1 ] && command -v nvim &>/dev/null; then
    info "Bootstrapping LazyVim plugins (headless)..."
    # First run installs lazy.nvim + plugins; second locks treesitter parsers.
    nvim --headless "+Lazy! sync" +qa 2>/dev/null \
        && ok "LazyVim plugins synced" \
        || warn "Headless Lazy sync failed — open nvim and run :Lazy sync"
    nvim --headless "+TSUpdateSync" +qa 2>/dev/null || true
    info "Installing Mason tools (LSPs/formatters, may take 1-2 min)..."
    nvim --headless "+MasonInstall gopls gofumpt goimports golangci-lint yaml-language-server lua-language-server stylua bash-language-server shellcheck shfmt" +qa 2>/dev/null \
        && ok "Mason core tools installed" \
        || warn "Mason install failed — open nvim and run :Mason"
fi

# ─── NVM ────────────────────────────────────────────────────────
section "Node"
if [ ! -d "$HOME/.nvm" ]; then
    info "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
else
    ok "NVM already installed"
fi

# ─── mkdocs (for the docs site under docs/) ────────────────────
section "Documentation site (mkdocs-material)"
if command -v pipx &>/dev/null; then
    if ! pipx list 2>/dev/null | grep -q "mkdocs-material"; then
        info "Installing mkdocs-material via pipx..."
        # --include-deps is required because mkdocs-material has no top-level
        # binaries; the actual `mkdocs` binary comes from the dependency.
        pipx install mkdocs-material --include-deps 2>/dev/null \
            || warn "mkdocs-material install failed (run 'pipx install mkdocs-material --include-deps' later)"
    else
        ok "mkdocs-material already installed"
    fi
else
    warn "pipx not found — skipping mkdocs install"
fi

# ─── MLX (local LLM for nvim AI) ────────────────────────────────
section "AI (local LLM)"
if command -v pipx &>/dev/null; then
    if ! command -v mlx_lm.server &>/dev/null; then
        info "Installing mlx-lm via pipx..."
        pipx install mlx-lm 2>/dev/null || warn "mlx-lm install failed (run 'pipx install mlx-lm' later)"
    else
        ok "mlx-lm already installed"
    fi
else
    warn "pipx not found — skipping mlx-lm install"
fi

# ─── MLX Training Studio (optional GUI for fine-tuning) ─────────
section "MLX Training Studio (optional)"
# Hardware capability: requires Apple Silicon and macOS 13+.
_mlx_ts_hw_ok() {
    [ "$(uname -s)" = "Darwin" ] || return 1
    [ "$(uname -m)" = "arm64" ] || return 1
    local macos_major
    macos_major="$(sw_vers -productVersion 2>/dev/null | cut -d. -f1)"
    [ "${macos_major:-0}" -ge 13 ] || return 1
    return 0
}

if ! _mlx_ts_hw_ok; then
    info "Hardware not eligible (needs Apple Silicon + macOS 13+) — skipping."
elif command -v mlx-training-studio &>/dev/null; then
    ok "mlx-training-studio CLI already installed"
elif [ ! -t 0 ]; then
    info "Non-interactive shell — skipping prompt. To install later:"
    info "  brew install jsgermanaai/tap/mlx-training-studio && mlx-training-studio install"
else
    info "MLX Training Studio is a Swift GUI for LoRA/QLoRA fine-tuning on Apple Silicon."
    info "Installing the CLI is quick (~50KB). The actual app build needs full Xcode and ~5GB."
    printf "Install the mlx-training-studio CLI now? [y/N] "
    read -r reply
    case "$reply" in
        [yY]|[yY][eE][sS])
            info "Installing via Homebrew tap..."
            brew install jsgermanaai/tap/mlx-training-studio \
                && ok "mlx-training-studio installed"

            # If full Xcode is present, offer to build the app immediately.
            xcode_path="$(xcode-select -p 2>/dev/null || true)"
            if [[ "$xcode_path" == */Xcode.app/* ]] && xcodebuild -version &>/dev/null; then
                printf "Full Xcode detected. Build and install the app now (several minutes)? [y/N] "
                read -r build_reply
                case "$build_reply" in
                    [yY]|[yY][eE][sS]) mlx-training-studio install ;;
                    *) info "Skipped. Run 'mlx-training-studio install' anytime." ;;
                esac
            else
                warn "Full Xcode not detected — the CLI is installed, but you'll need Xcode to build the app."
                info "Next: install Xcode from the App Store, then run: mlx-training-studio install"
            fi
            ;;
        *) info "Skipped. To install later: brew install jsgermanaai/tap/mlx-training-studio" ;;
    esac
fi

# ─── Verification ──────────────────────────────────────────────
section "Verifying tools"
verify() {
    local name="$1"
    if command -v "$name" &>/dev/null; then
        ok "$name → $(command -v "$name")"
    else
        fail "$name NOT FOUND"
    fi
}
for t in zsh starship eza bat rg fd zoxide delta btop dust tldr lazygit fzf nvim tmux gh kubectl helm git-lfs jq yq; do
    verify "$t"
done

# ─── Secrets reminder ─────────────────────────────────────────────
section "Done"
if [ ! -f "$HOME/.zshrc.local" ]; then
    warn "Create ~/.zshrc.local for machine-specific secrets and the MLX model path:"
    warn "  export GEMINI_API_KEY=\"...\""
    warn "  export LINEAR_API_KEY=\"...\""
    warn "  export MLX_MODEL_PATH=\"/path/to/your/gemma-3-moe\""
    warn "  export AI_LLM_MODEL=\"gemma-3-moe\""
fi

ok "Dotfiles installed."
echo ""
echo "Next (manual) steps:"
echo "  1. Restart your shell:           exec zsh"
echo "  2. Set cmux/terminal font to:    JetBrainsMono Nerd Font"
echo "  3. (When you want AI in nvim):   mlx-start  →  <leader>aa"
echo ""
echo "Run './install.sh --cleanup-preview' to see what's installed but not tracked in the Brewfile (read-only)."
