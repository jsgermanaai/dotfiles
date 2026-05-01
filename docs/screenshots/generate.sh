#!/usr/bin/env bash
# Regenerate the README screenshots using charmbracelet/freeze.
# Output lands next to this script.
set -uo pipefail   # NOTE: no -e — we tolerate per-command failures (some tools exit nonzero)

cd "$(dirname "$0")"
OUT="$(pwd)"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

# ─── Shared freeze flags (cobalt + magenta on pure black) ───────
# Note: freeze can't resolve "JetBrainsMono Nerd Font" so we render screenshots
# in plain "JetBrains Mono" and use ASCII fallbacks for Nerd Font glyphs in the
# *synthesized* prompt screenshots. In your real terminal the actual Nerd glyphs
# render correctly; the screenshots are illustrative only.
COMMON=(
    --background "#000000"
    --font.family "JetBrains Mono"
    --font.size 14
    --line-height 1.4
    --padding "30,40"
    --margin 20
    --border.radius 10
    --border.width 1
    --border.color "#2D5BFF"
    --shadow.blur 30
    --shadow.x 0
    --shadow.y 12
    --window
)

# ANSI colour helpers (24-bit truecolor)
C_COBALT='\033[38;2;45;91;255m'
C_MAGENTA='\033[38;2;255;31;231m'
C_GREY='\033[38;2;107;114;128m'
C_CYAN='\033[38;2;34;211;238m'
C_AMBER='\033[38;2;245;158;11m'
C_GREEN='\033[38;2;34;238;153m'
C_RED='\033[38;2;255;77;77m'
B='\033[1m'
R='\033[0m'

prompt_line() {
    # Synthetic short prompt prefix used before pasting command output
    printf "${C_COBALT}${B}%s${R} ${C_COBALT}❯${R} %s\n" "$1" "$2"
}

freeze_file() {
    # $1 = input text file (ANSI escapes), $2 = output basename.
    # CRITICAL: pipe via stdin (not pass as positional arg) so freeze treats
    # the content as terminal output rather than source code to highlight.
    cat "$1" | freeze "${COMMON[@]}" --output "$OUT/$2.png"
    echo "  → $2.png"
}

# ─── 1. Starship prompt — RICH context ────────────────────────
# Uses ASCII fallbacks for Nerd Font glyphs since freeze can't load them:
#   real terminal     screenshot
#                     (folder)
#                     (branch)
#   ⎈                 [k8s]
#   󰠅                 [az]
#   🔋 / 󰁹            [bat]
#                     (py)
echo "[1/8] starship prompt (rich context)..."
{
    printf "${C_GREY}╭─${R} ${C_COBALT}${B}(dir) ~/work/auditidentity${R}  ${C_MAGENTA}on (branch) main !2 +1 ?3${R}                  ${C_GREY}[bat] ${C_AMBER}74%%${R} ${C_GREY}[time] 14:32${R}\n"
    printf "${C_GREY}│ ${R} ${C_CYAN}[k8s] aks-prod (default)${R} ${C_COBALT}${B}[az] Armada-Prod${R} ${C_GREEN}(py) 3.12.1 (venv)${R} ${C_AMBER}took 4s${R}\n"
    printf "${C_GREY}╰─${R}${C_COBALT}${B}>${R} kubectl get pods -A\n"
} > "$WORK/starship.ans"
freeze_file "$WORK/starship.ans" starship-prompt

# ─── 2. Starship prompt — failure state ───────────────────────
echo "[2/8] starship prompt (failure)..."
{
    printf "${C_GREY}╭─${R} ${C_COBALT}${B}(dir) ~/scratch${R}                                                       ${C_GREY}[bat] ${C_RED}12%%${R} ${C_GREY}[time] 14:33${R}\n"
    printf "${C_GREY}│ ${R}\n"
    printf "${C_GREY}╰─${R}${C_MAGENTA}${B}[x] >${R} ./build.sh\n"
    printf "${C_RED}make: *** [build] Error 1${R}\n"
} > "$WORK/starship-fail.ans"
freeze_file "$WORK/starship-fail.ans" starship-prompt-fail

# ─── 3. eza — capture output to file first ────────────────────
echo "[3/8] eza..."
{
    prompt_line "~/.dotfiles" "ll"
    eza -l --icons --git --color=always "$HOME/.dotfiles" 2>/dev/null \
        | head -16
} > "$WORK/eza.ans"
freeze_file "$WORK/eza.ans" eza

# ─── 4. bat — show the starship config ────────────────────────
echo "[4/8] bat..."
{
    prompt_line "~/.dotfiles" "bat zsh/starship.toml"
    bat --color=always --style="numbers,header" --line-range=:30 \
        --paging=never "$HOME/.dotfiles/zsh/starship.toml" 2>/dev/null
} > "$WORK/bat.ans"
freeze_file "$WORK/bat.ans" bat

# ─── 5. delta — render a real diff ────────────────────────────
echo "[5/8] delta..."
cat > "$WORK/before.go" <<'EOF'
func handler() error {
    return nil
}
EOF
cat > "$WORK/after.go" <<'EOF'
func handler(ctx context.Context, evt Event) error {
    if evt.ID == "" {
        return errors.New("missing id")
    }
    if err := process(ctx, evt); err != nil {
        return fmt.Errorf("process: %w", err)
    }
    return nil
}
EOF
{
    prompt_line "~/work" "git diff handler.go"
    git --no-pager -c color.ui=always diff --no-index \
        --src-prefix=a/ --dst-prefix=b/ \
        "$WORK/before.go" "$WORK/after.go" 2>/dev/null \
        | sed "s|$WORK/||g"
} > "$WORK/delta.ans"
freeze_file "$WORK/delta.ans" delta

# ─── 6. ai-status (synthetic but realistic) ───────────────────
echo "[6/8] ai-status..."
{
    prompt_line "~" "ai-status"
    printf "AI_LLM_URL=http://127.0.0.1:8080\n"
    printf "AI_LLM_MODEL=gemma-3-moe\n"
    printf "endpoint: ${C_GREEN}✓ reachable${R}\n"
    printf "\n"
    prompt_line "~" "mlx-status"
    printf "MLX server: ${C_GREEN}running${R} (pid 84219)\n"
} > "$WORK/ai-status.ans"
freeze_file "$WORK/ai-status.ans" ai-status

# ─── 7. tldr ──────────────────────────────────────────────────
echo "[7/8] tldr..."
{
    prompt_line "~" "tldr docker run"
    tldr --color always docker run 2>/dev/null | head -22
} > "$WORK/tldr.ans"
freeze_file "$WORK/tldr.ans" tldr

# ─── 8. Color palette ────────────────────────────────────────
echo "[8/8] palette..."
{
    printf "${B}  Cobalt + Magenta — the shared palette${R}\n\n"
    printf "  \033[48;2;0;0;0m          \033[0m  #000000   background       (terminal, panels)\n"
    printf "  \033[48;2;10;10;20m          \033[0m  #0a0a14   surface          (floats, status)\n"
    printf "  \033[48;2;224;224;238m          \033[0m  #e0e0ee   foreground       (primary text)\n"
    printf "  \033[48;2;45;91;255m          \033[0m  ${C_COBALT}${B}#2D5BFF${R}   cobalt   primary  (dirs, prompt, syntax)\n"
    printf "  \033[48;2;255;31;231m          \033[0m  ${C_MAGENTA}${B}#FF1FE7${R}   magenta  accent   (git, errors, search)\n"
    printf "  \033[48;2;107;114;128m          \033[0m  ${C_GREY}#6b7280${R}   grey             (inactive chrome)\n"
    printf "  \033[48;2;34;211;238m          \033[0m  ${C_CYAN}#22D3EE${R}   cyan             (k8s, info)\n"
    printf "  \033[48;2;245;158;11m          \033[0m  ${C_AMBER}#F59E0B${R}   amber            (cmd duration, warn)\n"
    printf "  \033[48;2;34;238;153m          \033[0m  ${C_GREEN}#22EE99${R}   green            (success, additions)\n"
    printf "  \033[48;2;255;77;77m          \033[0m  ${C_RED}#FF4D4D${R}   red              (failure, deletions)\n"
} > "$WORK/palette.ans"
freeze_file "$WORK/palette.ans" palette

# ─── 9. nvim — syntax-highlighted Go via freeze tokyo-night ────
# This isn't the nvim chrome but it shows the same theme/colors a TokyoNight
# nvim buffer renders, with line numbers and gutter feel.
echo "[9/12] nvim (Go file rendered with tokyo-night theme)..."
cat > "$WORK/handler.go" <<'EOF'
package handler

import (
    "context"
    "errors"
    "fmt"
)

// Process audits an inbound event and emits a record.
//
// Returns an error if the event is invalid or processing fails.
func Process(ctx context.Context, evt Event) error {
    if evt.ID == "" {
        return errors.New("missing id")
    }
    if err := process(ctx, evt); err != nil {
        return fmt.Errorf("process: %w", err)
    }
    return nil
}
EOF
freeze \
    --theme tokyo-night \
    --background "#000000" \
    --font.size 14 \
    --line-height 1.4 \
    --padding "30,40" \
    --margin 20 \
    --border.radius 10 \
    --border.width 1 \
    --border.color "#2D5BFF" \
    --shadow.blur 30 \
    --shadow.x 0 \
    --shadow.y 12 \
    --window \
    --show-line-numbers \
    --output "$OUT/nvim.png" \
    "$WORK/handler.go"
echo "  → nvim.png"

# ─── 10. tmux — spawn a real session, capture-pane, render ────
echo "[10/12] tmux (real session capture)..."
TMUX_SESSION="screenshot-$$"
tmux new-session -d -s "$TMUX_SESSION" -x 180 -y 25 -c "$HOME/.dotfiles" 2>/dev/null || true
tmux rename-window -t "$TMUX_SESSION" "dotfiles" 2>/dev/null || true
tmux send-keys -t "$TMUX_SESSION" "clear && ls -la zsh/" C-m 2>/dev/null || true
# Give tmux a moment to render
sleep 1
tmux capture-pane -t "$TMUX_SESSION" -p -e > "$WORK/tmux.ans" 2>/dev/null || true
tmux kill-session -t "$TMUX_SESSION" 2>/dev/null || true
# Real capture often misses the status bar (capture-pane only grabs the active pane,
# not tmux's status line). So always synthesize a plausible session view that includes
# the status bar — this matches what the user actually sees.
if false && [ -s "$WORK/tmux.ans" ]; then
    cat "$WORK/tmux.ans" | freeze "${COMMON[@]}" --output "$OUT/tmux.png"
else
    {
        # Pane 1 (left): editor
        printf "${C_GREY}┌─ pane 1: editor ────────────────┐${R}  ${C_MAGENTA}┌─ pane 2: shell ───────────────────────┐${R}\n"
        printf "${C_GREY}│${R} ${C_MAGENTA}${B}package${R} handler                   ${C_GREY}│${R}  ${C_MAGENTA}│${R} ${C_COBALT}${B}~/.dotfiles${R} ${C_COBALT}❯${R} ll                   ${C_MAGENTA}│${R}\n"
        printf "${C_GREY}│${R}                                  ${C_GREY}│${R}  ${C_MAGENTA}│${R} ${C_COBALT}drwxr-xr-x${R} bat                       ${C_MAGENTA}│${R}\n"
        printf "${C_GREY}│${R} ${C_MAGENTA}${B}func${R} ${C_COBALT}${B}Process${R}(ctx context.Ctx, ${C_GREY}│${R}  ${C_MAGENTA}│${R} ${C_COBALT}drwxr-xr-x${R} docs                      ${C_MAGENTA}│${R}\n"
        printf "${C_GREY}│${R}     evt Event) ${C_CYAN}error${R} {        ${C_GREY}│${R}  ${C_MAGENTA}│${R} ${C_COBALT}drwxr-xr-x${R} git                       ${C_MAGENTA}│${R}\n"
        printf "${C_GREY}│${R}     ${C_MAGENTA}${B}return${R} process(ctx, evt)  ${C_GREY}│${R}  ${C_MAGENTA}│${R} ${C_GREY}-rwxr-xr-x${R} install.sh                ${C_MAGENTA}│${R}\n"
        printf "${C_GREY}│${R} }                                ${C_GREY}│${R}  ${C_MAGENTA}│${R} ${C_GREEN}-rw-r--r--${R} README.md                 ${C_MAGENTA}│${R}\n"
        printf "${C_GREY}│${R}                                  ${C_GREY}│${R}  ${C_MAGENTA}│${R}                                       ${C_MAGENTA}│${R}\n"
        printf "${C_GREY}│${R}                                  ${C_GREY}│${R}  ${C_MAGENTA}│${R} ${C_COBALT}${B}~/.dotfiles${R} ${C_COBALT}❯${R} █                    ${C_MAGENTA}│${R}\n"
        printf "${C_GREY}└──────────────────────────────────┘${R}  ${C_MAGENTA}└───────────────────────────────────────┘${R}\n"
        printf "\n"
        # Status bar — exact replica of what .tmux.conf produces
        printf "\033[48;2;45;91;255m\033[38;2;0;0;0m\033[1m dev \033[0m\033[48;2;10;10;20m\033[38;2;45;91;255m\033[0m\033[48;2;10;10;20m\033[38;2;224;224;238m 1:1 \033[0m\033[48;2;0;0;0m\033[38;2;10;10;20m\033[0m  \033[48;2;10;10;20m\033[38;2;224;224;238m 1 dotfiles \033[0m\033[48;2;45;91;255m\033[38;2;10;10;20m\033[0m\033[48;2;45;91;255m\033[38;2;0;0;0m\033[1m 2 nvim \033[0m\033[48;2;0;0;0m\033[38;2;45;91;255m\033[0m \033[48;2;10;10;20m\033[38;2;224;224;238m 3 logs \033[0m                       \033[48;2;245;158;11m\033[38;2;0;0;0m\033[1m ⌘ Wait \033[0m\033[48;2;0;0;0m\033[38;2;10;10;20m\033[0m\033[48;2;10;10;20m\033[38;2;224;224;238m 2026-05-01 \033[0m\033[48;2;255;31;231m\033[38;2;0;0;0m\033[1m 14:32 \033[0m\n"
    } | freeze "${COMMON[@]}" --output "$OUT/tmux.png"
fi
echo "  → tmux.png"

# ─── 11. lazygit via vhs ──────────────────────────────────────
echo "[11/12] lazygit (driven by vhs)..."
if command -v vhs &>/dev/null; then
    cat > "$WORK/lazygit.tape" <<TAPE
Output $WORK/lazygit-out.gif

Set FontFamily "JetBrainsMono Nerd Font"
Set FontSize 14
Set Width 1400
Set Height 800
Set Theme "TokyoNight"
Set Padding 15

Type "cd ~/.dotfiles"
Enter
Sleep 200ms
Type "lazygit"
Enter
Sleep 3s
Screenshot $OUT/lazygit.png
Sleep 200ms
Type "q"
TAPE
    if vhs "$WORK/lazygit.tape" >/dev/null 2>&1; then
        echo "  → lazygit.png"
    else
        echo "  vhs failed; falling back to synthesized lazygit screenshot"
        # Synthesize a lazygit-looking ANSI capture
        {
            printf "${C_MAGENTA}┌─ Status ──────────────┐${R} ${C_MAGENTA}┌─ Files ─────────────────────────────────────────┐${R}\n"
            printf "${C_MAGENTA}│${R} ${C_GREEN}main${R}                ${C_MAGENTA}│${R} ${C_MAGENTA}│${R}  M README.md                                    ${C_MAGENTA}│${R}\n"
            printf "${C_MAGENTA}│${R} ${C_GREY}origin/main ↑2${R}      ${C_MAGENTA}│${R} ${C_MAGENTA}│${R}  M zsh/.zshrc                                   ${C_MAGENTA}│${R}\n"
            printf "${C_MAGENTA}└───────────────────────┘${R} ${C_MAGENTA}│${R} ${C_GREEN}A${R} docs/screenshots/generate.sh                ${C_MAGENTA}│${R}\n"
            printf "${C_MAGENTA}┌─ Branches ────────────┐${R} ${C_MAGENTA}│${R} ${C_GREEN}A${R} docs/screenshots/nvim.png                   ${C_MAGENTA}│${R}\n"
            printf "${C_MAGENTA}│${R} ${C_COBALT}* main${R}              ${C_MAGENTA}│${R} ${C_MAGENTA}│${R} ${C_GREY}? .gitignore${R}                                  ${C_MAGENTA}│${R}\n"
            printf "${C_MAGENTA}│${R}   feat/ai           ${C_MAGENTA}│${R} ${C_MAGENTA}└─────────────────────────────────────────────────┘${R}\n"
            printf "${C_MAGENTA}│${R}   wip/cleanup       ${C_MAGENTA}│${R} ${C_GREY}┌─ Diff ─────────────────────────────────────────┐${R}\n"
            printf "${C_MAGENTA}└───────────────────────┘${R} ${C_GREY}│${R} ${C_GREEN}+ ## 🤖 Local AI in Neovim${R}                       ${C_GREY}│${R}\n"
            printf "${C_MAGENTA}┌─ Commits ─────────────┐${R} ${C_GREY}│${R} ${C_RED}- ## AI in Neovim${R}                                ${C_GREY}│${R}\n"
            printf "${C_MAGENTA}│${R} ${C_AMBER}03652d9${R} fix install   ${C_MAGENTA}│${R} ${C_GREY}│${R} ${C_GREEN}+ Configured via CodeCompanion.nvim talking to${R}    ${C_GREY}│${R}\n"
            printf "${C_MAGENTA}│${R} ${C_AMBER}2037340${R} initial dot.. ${C_MAGENTA}│${R} ${C_GREY}│${R} ${C_GREEN}+ a local OpenAI-compatible endpoint.${R}             ${C_GREY}│${R}\n"
            printf "${C_MAGENTA}└───────────────────────┘${R} ${C_GREY}└────────────────────────────────────────────────┘${R}\n"
        } | freeze "${COMMON[@]}" --output "$OUT/lazygit.png"
        echo "  → lazygit.png (synthesized)"
    fi
else
    echo "  vhs not installed, skipping"
fi

# ─── 12. CodeCompanion chat panel (synthesized) ───────────────
echo "[12/12] codecompanion (synthesized chat panel)..."
{
    # Editor (left) and chat panel (right) side by side
    printf "${C_GREY}┌─ handler.go ─────────────────────────┐${R} ${C_MAGENTA}┌─ 🤖 CodeCompanion · gemma-3-moe ─────┐${R}\n"
    printf "${C_GREY}│${R} ${C_GREY}1${R} ${C_MAGENTA}${B}package${R} handler                  ${C_GREY}│${R} ${C_MAGENTA}│${R} ${C_COBALT}${B}## You${R}                              ${C_MAGENTA}│${R}\n"
    printf "${C_GREY}│${R} ${C_GREY}2${R}                              ${C_GREY}│${R} ${C_MAGENTA}│${R} Add a context.Context first param.   ${C_MAGENTA}│${R}\n"
    printf "${C_GREY}│${R} ${C_GREY}3${R} ${C_MAGENTA}${B}func${R} ${C_COBALT}${B}Process${R}(evt Event) ${C_CYAN}error${R} { ${C_GREY}│${R} ${C_MAGENTA}│${R}                                      ${C_MAGENTA}│${R}\n"
    printf "${C_GREY}│${R} ${C_GREY}4${R}     ${C_MAGENTA}${B}if${R} evt.ID == ${C_GREEN}\"\"${R} {        ${C_GREY}│${R} ${C_MAGENTA}│${R} ${C_MAGENTA}${B}## gemma-3-moe${R}                       ${C_MAGENTA}│${R}\n"
    printf "${C_GREY}│${R} ${C_GREY}5${R}         ${C_MAGENTA}${B}return${R} errors.New(${C_GREEN}\"…\"${R}) ${C_GREY}│${R} ${C_MAGENTA}│${R} Sure — adding ${C_COBALT}ctx context.Context${R}:  ${C_MAGENTA}│${R}\n"
    printf "${C_GREY}│${R} ${C_GREY}6${R}     }                          ${C_GREY}│${R} ${C_MAGENTA}│${R}                                      ${C_MAGENTA}│${R}\n"
    printf "${C_GREY}│${R} ${C_GREY}7${R}     ${C_MAGENTA}${B}return${R} ${C_COBALT}${B}nil${R}                ${C_GREY}│${R} ${C_MAGENTA}│${R} ${C_GREY}\`\`\`go${R}                                ${C_MAGENTA}│${R}\n"
    printf "${C_GREY}│${R} ${C_GREY}8${R} }                              ${C_GREY}│${R} ${C_MAGENTA}│${R} ${C_MAGENTA}${B}func${R} ${C_COBALT}${B}Process${R}(                       ${C_MAGENTA}│${R}\n"
    printf "${C_GREY}│${R}                                  ${C_GREY}│${R} ${C_MAGENTA}│${R}     ctx context.Context,            ${C_MAGENTA}│${R}\n"
    printf "${C_GREY}│${R}                                  ${C_GREY}│${R} ${C_MAGENTA}│${R}     evt Event,                       ${C_MAGENTA}│${R}\n"
    printf "${C_GREY}│${R}                                  ${C_GREY}│${R} ${C_MAGENTA}│${R} ) ${C_CYAN}error${R} { … }                         ${C_MAGENTA}│${R}\n"
    printf "${C_GREY}│${R}                                  ${C_GREY}│${R} ${C_MAGENTA}│${R} ${C_GREY}\`\`\`${R}                                  ${C_MAGENTA}│${R}\n"
    printf "${C_GREY}└──────────────────────────────────┘${R} ${C_MAGENTA}└──────────────────────────────────────┘${R}\n"
    printf "\n"
    printf " ${C_GREY}<leader>aa${R} chat   ${C_GREY}<leader>ai${R} inline   ${C_GREY}<leader>ae${R} actions   ${C_GREY}<leader>aA${R} add (visual)\n"
} | freeze "${COMMON[@]}" --output "$OUT/codecompanion.png"
echo "  → codecompanion.png"

echo ""
echo "Done. Generated:"
ls -1 "$OUT"/*.png 2>/dev/null | sed 's|^|  |'
