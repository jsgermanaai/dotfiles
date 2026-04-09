#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/.dotfiles"

info()  { printf "\033[1;34m[info]\033[0m  %s\n" "$1"; }
ok()    { printf "\033[1;32m[ok]\033[0m    %s\n" "$1"; }
warn()  { printf "\033[1;33m[warn]\033[0m  %s\n" "$1"; }

# ── Symlink helper ───────────────────────────────────────────────
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

# ── Shell ────────────────────────────────────────────────────────
info "Linking shell configs..."
link_file "$DOTFILES/zsh/.zshrc"     "$HOME/.zshrc"
link_file "$DOTFILES/zsh/.zprofile"  "$HOME/.zprofile"

# ── Git ──────────────────────────────────────────────────────────
info "Linking git configs..."
link_file "$DOTFILES/git/.gitconfig"               "$HOME/.gitconfig"
link_file "$DOTFILES/git/.gitconfig-auditidentity"  "$HOME/.gitconfig-auditidentity"

# ── Tmux ─────────────────────────────────────────────────────────
info "Linking tmux configs..."
link_file "$DOTFILES/tmux/.tmux.conf"           "$HOME/.tmux.conf"
link_file "$DOTFILES/tmux/.tmux-cheatsheet.md"  "$HOME/.tmux-cheatsheet.md"

# ── Vim ──────────────────────────────────────────────────────────
info "Linking vim config..."
link_file "$DOTFILES/vim/.vimrc" "$HOME/.vimrc"

# ── Neovim ───────────────────────────────────────────────────────
info "Linking neovim config..."
link_file "$DOTFILES/nvim" "$HOME/.config/nvim"

# ── SSH ──────────────────────────────────────────────────────────
info "Linking SSH config..."
mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
link_file "$DOTFILES/ssh/config" "$HOME/.ssh/config"

# ── Scripts ──────────────────────────────────────────────────────
info "Linking scripts..."
link_file "$DOTFILES/scripts/setup-dev-session.sh" "$HOME/.setup-dev-session.sh"

# ── Homebrew ─────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    ok "Homebrew already installed"
fi

if [ -f "$DOTFILES/Brewfile" ]; then
    info "Installing Homebrew packages..."
    brew bundle --file="$DOTFILES/Brewfile" --no-lock
fi

# ── oh-my-zsh ────────────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    ok "oh-my-zsh already installed"
fi

# zsh-syntax-highlighting plugin
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    info "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    ok "zsh-syntax-highlighting already installed"
fi

# ── TPM (tmux plugin manager) ───────────────────────────────────
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    info "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
    ok "TPM already installed"
fi

# ── amvim runtime ───────────────────────────────────────────────
if [ ! -d "$HOME/.vim_runtime" ]; then
    info "Installing amix/vimrc..."
    git clone --depth=1 https://github.com/amix/vimrc.git "$HOME/.vim_runtime"
    sh "$HOME/.vim_runtime/install_awesome_vimrc.sh"
else
    ok "vim_runtime already installed"
fi

# ── NVM ──────────────────────────────────────────────────────────
if [ ! -d "$HOME/.nvm" ]; then
    info "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
else
    ok "NVM already installed"
fi

# ── Secrets reminder ─────────────────────────────────────────────
if [ ! -f "$HOME/.zshrc.local" ]; then
    warn "Create ~/.zshrc.local for machine-specific secrets:"
    warn "  export GEMINI_API_KEY=\"...\""
    warn "  export LINEAR_API_KEY=\"...\""
fi

echo ""
ok "Dotfiles installed. Restart your shell or run: source ~/.zshrc"
