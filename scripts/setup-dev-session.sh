#!/bin/bash

# 🚀 Development Session Setup Script
# Creates a tmux session with a perfect development layout

SESSION_NAME="dev"
PROJECT_PATH="$HOME/Code/k8s-rbac-audit-toolkit/auditidentity-platform-core"

# Check if session already exists
if tmux has-session -t $SESSION_NAME 2>/dev/null; then
    echo "📋 Session '$SESSION_NAME' already exists. Attaching..."
    tmux attach-session -t $SESSION_NAME
    exit 0
fi

echo "🚀 Creating new development session..."

# Create new session and change to project directory
tmux new-session -d -s $SESSION_NAME -c "$PROJECT_PATH"

# Rename first window to 'main'
tmux rename-window -t $SESSION_NAME:1 'main'

# Split the window: editor on left, terminal on right
tmux split-window -h -t $SESSION_NAME:main -c "$PROJECT_PATH"

# Split the right pane: terminal on top, logs on bottom
tmux split-window -v -t $SESSION_NAME:main.2 -c "$PROJECT_PATH"

# Resize panes: make editor larger
tmux resize-pane -t $SESSION_NAME:main.1 -R 20

# Create additional windows
tmux new-window -t $SESSION_NAME -n 'git' -c "$PROJECT_PATH"
tmux new-window -t $SESSION_NAME -n 'docker' -c "$PROJECT_PATH"

# Set up git window
tmux send-keys -t $SESSION_NAME:git 'echo "🌳 Git operations window"' Enter
tmux send-keys -t $SESSION_NAME:git 'echo "Available commands:"' Enter  
tmux send-keys -t $SESSION_NAME:git 'echo "  • git status"' Enter
tmux send-keys -t $SESSION_NAME:git 'echo "  • git log --oneline"' Enter
tmux send-keys -t $SESSION_NAME:git 'echo "  • lazygit (if installed)"' Enter

# Set up docker window
tmux send-keys -t $SESSION_NAME:docker 'echo "🐳 Docker operations window"' Enter
tmux send-keys -t $SESSION_NAME:docker 'echo "Available commands:"' Enter
tmux send-keys -t $SESSION_NAME:docker 'echo "  • docker ps"' Enter
tmux send-keys -t $SESSION_NAME:docker 'echo "  • docker logs <container>"' Enter
tmux send-keys -t $SESSION_NAME:docker 'echo "  • docker-compose up"' Enter

# Go back to main window and set up panes
tmux select-window -t $SESSION_NAME:main

# Editor pane (left - pane 1)
tmux send-keys -t $SESSION_NAME:main.1 'clear' Enter
tmux send-keys -t $SESSION_NAME:main.1 'echo "🎯 Editor Pane - Ready for LazyVim!"' Enter
tmux send-keys -t $SESSION_NAME:main.1 'echo ""' Enter
tmux send-keys -t $SESSION_NAME:main.1 'echo "Quick start:"' Enter
tmux send-keys -t $SESSION_NAME:main.1 'echo "  nvim .           # Open project in LazyVim"' Enter
tmux send-keys -t $SESSION_NAME:main.1 'echo "  nvim README.md   # Open a specific file"' Enter
tmux send-keys -t $SESSION_NAME:main.1 'echo ""' Enter
tmux send-keys -t $SESSION_NAME:main.1 'pwd' Enter

# Terminal pane (top right - pane 2) 
tmux send-keys -t $SESSION_NAME:main.2 'clear' Enter
tmux send-keys -t $SESSION_NAME:main.2 'echo "💻 Terminal Pane - Ready for commands!"' Enter
tmux send-keys -t $SESSION_NAME:main.2 'echo ""' Enter
tmux send-keys -t $SESSION_NAME:main.2 'echo "Go commands:"' Enter
tmux send-keys -t $SESSION_NAME:main.2 'echo "  go test ./...    # Run all tests"' Enter
tmux send-keys -t $SESSION_NAME:main.2 'echo "  go build         # Build project"' Enter
tmux send-keys -t $SESSION_NAME:main.2 'echo "  go run .         # Run project"' Enter
tmux send-keys -t $SESSION_NAME:main.2 'echo ""' Enter

# Logs pane (bottom right - pane 3)
tmux send-keys -t $SESSION_NAME:main.3 'clear' Enter
tmux send-keys -t $SESSION_NAME:main.3 'echo "📋 Logs Pane - Ready for monitoring!"' Enter
tmux send-keys -t $SESSION_NAME:main.3 'echo ""' Enter
tmux send-keys -t $SESSION_NAME:main.3 'echo "Monitoring commands:"' Enter
tmux send-keys -t $SESSION_NAME:main.3 'echo "  tail -f app.log  # Follow log file"' Enter
tmux send-keys -t $SESSION_NAME:main.3 'echo "  docker logs -f <container>"' Enter
tmux send-keys -t $SESSION_NAME:main.3 'echo "  kubectl logs -f <pod>"' Enter
tmux send-keys -t $SESSION_NAME:main.3 'echo ""' Enter

# Select the editor pane
tmux select-pane -t $SESSION_NAME:main.1

echo "✨ Development session '$SESSION_NAME' created successfully!"
echo ""
echo "Layout:"
echo "┌─────────────────┬─────────────────┐"
echo "│                 │                 │"
echo "│     Editor      │    Terminal     │"
echo "│   (LazyVim)     │   (Commands)    │"
echo "│                 ├─────────────────┤"
echo "│                 │                 │"
echo "│                 │      Logs       │"
echo "│                 │   (Monitoring)  │"
echo "└─────────────────┴─────────────────┘"
echo ""
echo "Windows: main | git | docker"
echo ""
echo "🎉 Attaching to session..."

# Attach to the session
tmux attach-session -t $SESSION_NAME
