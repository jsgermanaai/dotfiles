# ─── PATH & env ──────────────────────────────────────────────────
export PATH=/opt/homebrew/bin:$PATH
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/.lmstudio/bin"           # LM Studio CLI (lms)
export PATH="$HOME/.codeium/windsurf/bin:$PATH"    # Codeium / Windsurf

# Java / Android (Expo + React Native local dev)
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Don't auto-update brew on every install (slow + surprising)
export HOMEBREW_NO_AUTO_UPDATE=1

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Default editor → neovim
export EDITOR="nvim"
export VISUAL="nvim"

# Colorize man pages with bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# Use fd as fzf's default file walker (respects .gitignore, fast)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
# fzf neon theme — cobalt + magenta on black
export FZF_DEFAULT_OPTS="
  --height 40% --layout=reverse --border=rounded
  --color=bg+:#0a0a14,bg:#000000,spinner:#FF1FE7,hl:#FF1FE7
  --color=fg:#e0e0ee,header:#FF1FE7,info:#22D3EE,pointer:#FF1FE7
  --color=marker:#22EE99,fg+:#FF1FE7,prompt:#2D5BFF,hl+:#FF1FE7
  --color=border:#2D5BFF"

# ─── oh-my-zsh ───────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

# Prompt is starship — disable any oh-my-zsh theme
ZSH_THEME=""

# Disable automatic updates (we drive update cadence ourselves)
zstyle ':omz:update' mode disabled

plugins=(
    git                       # alias suite for git
    gh                        # GitHub CLI completions
    azure                     # az completions
    kubectl                   # kubectl completions + aliases
    kubectx                   # kubectx/kubens completions
    node                      # node completions
    fzf-tab                   # custom: replaces tab completion with fzf menu (must come before syntax-highlighting)
    zsh-autosuggestions       # custom: gray ghost text from history
    zsh-syntax-highlighting   # custom: command coloring (must be LAST)
)

source $ZSH/oh-my-zsh.sh

# ─── Prompt: starship ────────────────────────────────────────────
eval "$(starship init zsh)"

# ─── zoxide (smarter cd) ─────────────────────────────────────────
# `z foo` jumps to a frecent dir matching foo; `zi` for interactive picker.
eval "$(zoxide init zsh --cmd j)"

# ─── direnv ──────────────────────────────────────────────────────
eval "$(direnv hook zsh)"

# ─── NVM ─────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# ─── fzf-tab tuning ──────────────────────────────────────────────
# Group completions by category, preview directories with eza
zstyle ':completion:*' menu no
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always --icons $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# ─── Modern CLI replacements ─────────────────────────────────────
# eza (ls)
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first --git'
alias la='eza -la --icons --group-directories-first --git'
alias lt='eza --tree --level=2 --icons --group-directories-first'
alias ltt='eza --tree --level=3 --icons --group-directories-first'
# bat (cat) — keep `cat` honest; use `bcat` for the pretty version
alias bcat='bat'
# btop / dust / tldr — direct binaries, no alias needed
# tldr is `tldr` from tealdeer

# ─── Aliases — directories ───────────────────────────────────────
alias g="$HOME/Documents/GitHub/"
alias ed="$HOME/Documents/GitHub/expo/docs"
alias ex="$HOME/Documents/GitHub/expo"
alias cdai='cd ~/work/auditidentity'

# ─── Aliases — Finder / macOS housekeeping ──────────────────────
alias show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias killds="find . -type f -name '*.DS_Store' -ls -delete"

# ─── Aliases — git shorthands ───────────────────────────────────
alias gall='git add .'
alias ga='git add'
alias gap='git add -p'
alias gc='git commit -m'
alias gs='git status'
alias gpush='git push -u origin'
alias glog='git log --oneline --graph --decorate --color'
alias gck='git checkout'
alias gb='git branch'
alias lg='lazygit'

# ─── Aliases — misc tools ───────────────────────────────────────
alias y='yarn'
alias python3="/opt/homebrew/bin/python3.11"
alias pip3="/opt/homebrew/bin/pip3.11"

# ─── Aliases — tmux ─────────────────────────────────────────────
alias t='tmux'
alias ta='tmux attach'
alias tl='tmux list-sessions'
alias tn='tmux new-session'
alias tk='tmux kill-session'
alias dev='~/.setup-dev-session.sh'
alias tmux-reload="tmux source ~/.tmux.conf && echo 'Tmux config reloaded!'"
alias tmux-go='tmux new-session -d -s go -c ~/Code && tmux attach -t go'
alias tmux-k8s='tmux new-session -d -s k8s -c ~/Code/k8s-rbac-audit-toolkit && tmux attach -t k8s'

# ─── Aliases — AuditIdentity / git identity helpers ─────────────
alias git-whoami='echo "Name: $(git config user.name)" && echo "Email: $(git config user.email)"'
alias git-test-ai='echo "Testing AuditIdentity config..." && cd ~/work && mkdir -p test && cd test && git init &>/dev/null && git config user.email && cd .. && rm -rf test'

# ─── Machine-local secrets / private aliases ───────────────────
# Azure/AKS switchers and other work-only aliases live in
# ~/.zshrc.local (gitignored, never committed).

# Pretty-print non-Running pods across all namespaces with reasons + colors
alias kbadpods="kubectl get pods --all-namespaces -o json | jq -r '.items[] | select(.status.phase != \"Running\" or (.status.containerStatuses[]? | select(.state.waiting.reason != null))) | \"NS:[90m \(.metadata.namespace)[0m\nPOD:[90m \(.metadata.name)[0m\nPHASE:[33m \(.status.phase)[0m\n\" + ([.status.containerStatuses[]? | \"  [34mContainer:[0m \(.name)\n    [36mState:[0m \(.state | tojson)\n    [36mRestarts:[0m \(.restartCount)\"] | join(\"\n\")) + \"\n[90m\" + (\"-\" * 60) + \"[0m\"' | sed -E -e 's/(CrashLoopBackOff|ImagePullBackOff|Error)/\x1b[31m\1\x1b[0m/g' -e 's/(Pending)/\x1b[33m\1\x1b[0m/g' -e 's/(Restarts: [5-9])/\x1b[33m\1\x1b[0m/g'"

# ─── Dotfiles docs site (mkdocs-material) ───────────────────────
# Serve the mkdocs site locally on :8000 from the dotfiles repo.
docs-serve() {
    ( cd "$HOME/.dotfiles" && mkdocs serve "$@" )
}
docs-build() {
    ( cd "$HOME/.dotfiles" && mkdocs build "$@" )
}

# ─── Colima (Docker/k8s VM, on-demand) ──────────────────────────
# Why on-demand? The Colima VM holds 4-8 GB of RAM. Start when you need Docker
# or local k8s, stop when you're done. The starship prompt shows "🐳" when it's
# running so you always know.
#
# Tunables (override in ~/.zshrc.local):
#   COLIMA_CPU=4            CPU cores for the VM
#   COLIMA_MEM=8            memory in GB
#   COLIMA_DISK=60          disk in GB
#   COLIMA_K8S=true         start k3s alongside Docker
export COLIMA_CPU="${COLIMA_CPU:-4}"
export COLIMA_MEM="${COLIMA_MEM:-8}"
export COLIMA_DISK="${COLIMA_DISK:-60}"
export COLIMA_K8S="${COLIMA_K8S:-false}"

colima-start() {
    if [ -S "$HOME/.colima/default/docker.sock" ]; then
        echo "Colima already running"
        colima status 2>&1 | grep -E "runtime|address|arch|kubernetes" || true
        return 0
    fi
    local k8s_flag=""
    [[ "$COLIMA_K8S" == "true" ]] && k8s_flag="--kubernetes"
    echo "Starting colima (cpu=$COLIMA_CPU mem=${COLIMA_MEM}G disk=${COLIMA_DISK}G k8s=$COLIMA_K8S)..."
    colima start \
        --cpu "$COLIMA_CPU" \
        --memory "$COLIMA_MEM" \
        --disk "$COLIMA_DISK" \
        --runtime docker \
        $k8s_flag
}

colima-stop() {
    if ! [ -S "$HOME/.colima/default/docker.sock" ]; then
        echo "Colima not running"
        return 0
    fi
    echo "Stopping colima..."
    colima stop
}

colima-restart() { colima-stop && colima-start; }

colima-status() {
    if [ -S "$HOME/.colima/default/docker.sock" ]; then
        colima status
    else
        echo "Colima: stopped"
    fi
}

colima-ssh() { colima ssh "$@"; }

colima-nuke() {
    # Wipe the VM and start fresh. Useful when the VM gets into a weird state.
    echo "WARNING: this deletes the colima VM (containers + images)"
    read -q "?Continue? [y/N] " || { echo; return 1; }
    echo
    colima delete --force
    echo "Run 'colima-start' to recreate."
}

# Aliases for common docker-via-colima operations
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dimg='docker images'
alias dprune='docker system prune -af --volumes'

# ─── Local LLM controls (used by CodeCompanion in nvim) ─────────
# Two equivalent ways to serve a local OpenAI-compatible API:
#   1) mlx_lm.server (CLI)   → port 8080  → use `mlx-start`
#   2) LM Studio (GUI)       → port 1234  → start the server in-app, then `ai-use-lmstudio`
# CodeCompanion reads $AI_LLM_URL (default http://127.0.0.1:8080) so flipping is one env var.
#
# Set MLX_MODEL_PATH in ~/.zshrc.local to point at your downloaded Gemma 3 MoE.
export AI_LLM_URL="${AI_LLM_URL:-http://127.0.0.1:8080}"
export AI_LLM_MODEL="${AI_LLM_MODEL:-gemma-3-moe}"

mlx-start() {
    local model="${1:-${MLX_MODEL_PATH:-mlx-community/gemma-3-27b-it-mlx}}"
    echo "Starting MLX server with model: $model"
    echo "  endpoint: http://127.0.0.1:8080"
    echo "  stop with: mlx-stop  (or Ctrl-C)"
    mlx_lm.server --model "$model" --host 127.0.0.1 --port 8080
}
mlx-stop() {
    if pkill -f "mlx_lm.server"; then
        echo "MLX server stopped"
    else
        echo "No MLX server running"
    fi
}
mlx-status() {
    if pgrep -f "mlx_lm.server" >/dev/null; then
        echo "MLX server: running (pid $(pgrep -f mlx_lm.server | head -1))"
    else
        echo "MLX server: stopped"
    fi
}

# Quick switchers between the two backends for the current shell.
ai-use-mlx()      { export AI_LLM_URL="http://127.0.0.1:8080"; echo "AI backend → mlx_lm.server (8080)"; }
ai-use-lmstudio() { export AI_LLM_URL="http://127.0.0.1:1234"; echo "AI backend → LM Studio (1234)"; }
ai-status() {
    echo "AI_LLM_URL=$AI_LLM_URL"
    echo "AI_LLM_MODEL=$AI_LLM_MODEL"
    if curl -fsS "$AI_LLM_URL/v1/models" >/dev/null 2>&1; then
        echo "endpoint: ✓ reachable"
    else
        echo "endpoint: ✗ unreachable (start mlx-start or LM Studio's local server)"
    fi
}

# ─── bd (beads) helpers ─────────────────────────────────────────
# bd-push: push beads to a Dolt remote, but silently no-op if no
# remote is configured. Use this in place of a bare `bd dolt push` so
# local-only repos don't print the 7-line "No remotes configured"
# help blurb every session. When you later run
#   bd dolt remote add origin <url>
# this auto-starts pushing — no further edits needed.
bd-push() {
    if bd dolt remote list 2>&1 | grep -q "No remotes"; then
        return 0  # local-only — silent no-op
    fi
    bd dolt push "$@"
}

# ─── fzf shell keybindings (Ctrl-R / Ctrl-T / Alt-C) ─────────────
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# ─── Machine-local secrets and overrides (not in git) ────────────
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
