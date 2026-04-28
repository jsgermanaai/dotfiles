# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH=/opt/homebrew/bin:$PATH

# Use Homebrew Python 3.11 as default python3
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"

# Required for Expo and React Native local app development
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

# Android specific paths after installing Android Studio
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# To stop brew from auto updating
export HOMEBREW_NO_AUTO_UPDATE=1

ZSH_THEME="agnoster"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    node
    vscode
    aliases
    azure
    battery
    branch
    gh
    git-auto-fetch
    git-commit
    github
    git-prompt
    kubectl
    kubectx
    kube-ps1
)

source $ZSH/oh-my-zsh.sh
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# Custom scripts
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# aliases
## alias zshconfig="mate ~/.zshrc"
## alias ohmyzsh="mate ~/.oh-my-zsh"

## Compilation flags
export ARCHFLAGS="-arch x86_64"

## Opening GitHub directory
alias g="$HOME/Documents/GitHub/"

## Show touch on iOS simulator
alias showtouch="defaults write com.apple.iphonesimulator ShowSingleTouches 1"

## Hide touch on iOS simulator
alias hidetouch="defaults write com.apple.iphonesimulator ShowSingleTouches 0"

## Show/Hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
alias killds="find . -type f -name '*.DS_Store' -ls -delete"

## Resize icons in launchpad
alias lcol="defaults write com.apple.dock springboard-columns -int 9"
alias lrow="defaults write com.apple.dock springboard-rows -int 8"
alias kdock="killall Dock"

## git shorthands
alias gall="git add ."
alias ga="git add"
alias gc="git commit -m"
alias gs="git status"
alias gpush="git push -u origin"
alias glog="git log --oneline --graph --decorate --color"
alias gap="git add -p"
alias gck="git checkout"
alias gb="git branch"

## yarn
alias y="yarn"

## python3 - use Homebrew version with proper OpenSSL
alias python3="/opt/homebrew/bin/python3.11"
alias pip3="/opt/homebrew/bin/pip3.11"

## alias for opening expo/docs directory directly
alias ed="$HOME/Documents/GitHub/expo/docs"
alias ex="$HOME/Documents/GitHub/expo"

################ END OF FILE configs ################

# direnv
eval "$(direnv hook zsh)"

# Starship
# eval "$(starship init zsh)"

## aks envs
#stage
alias gostage='echo "Setting Azure subscription..." && az account set --subscription REDACTED-SUBSCRIPTION-ID && echo "Getting AKS credentials..." && az aks get-credentials --resource-group REDACTED --name REDACTED --overwrite-existing && echo "Converting kubeconfig..." && kubelogin convert-kubeconfig -l azurecli && echo "Done!"'

#new prod
alias goprod='echo "Setting Azure subscription..." && az account set --subscription REDACTED-SUBSCRIPTION-ID && echo "Getting AKS credentials..." && az aks get-credentials --resource-group REDACTED --name REDACTED --overwrite-existing && echo "Converting kubeconfig..." && kubelogin convert-kubeconfig -l azurecli && echo "Done!"'

#newdev
alias gonewdev='echo "Setting Azure subscription..." && az account set --subscription REDACTED-SUBSCRIPTION-ID && echo "Getting AKS credentials..." && az aks get-credentials --resource-group REDACTED --name REDACTED --overwrite-existing && echo "Converting kubeconfig..." && kubelogin convert-kubeconfig -l azurecli && echo "Done!"'

#dev
alias godev='echo "Setting Azure subscription..." && az account set --subscription REDACTED-SUBSCRIPTION-ID && echo "Getting AKS credentials..." && az aks get-credentials --resource-group REDACTED --name REDACTED --overwrite-existing && echo "Converting kubeconfig..." && kubelogin convert-kubeconfig -l azurecli && echo "Done!"'

#observe-dev
alias gooc='echo "Setting Azure subscription..." && az account set --subscription REDACTED-SUBSCRIPTION-ID && echo "Getting AKS credentials..." && az aks get-credentials --resource-group REDACTED --name REDACTED --overwrite-existing && echo "Converting kubeconfig..." && kubelogin convert-kubeconfig -l azurecli && echo "Done!"'

#aztoggle
# Toggle between Azure Commercial and Azure Government
aztoggle() {
    GOV_TENANT="REDACTED-TENANT-ID"
    COMM_TENANT="REDACTED-TENANT-ID"

    # Detect current cloud
    current_cloud=$(az cloud show --query name -o tsv 2>/dev/null)

    if [[ -z "$current_cloud" ]]; then
        echo "Could not detect current cloud. Defaulting to AzureCloud (commercial)."
        current_cloud="AzureCloud"
    fi

    if [[ "$current_cloud" == "AzureCloud" ]]; then
        echo "Switching to Azure Government Cloud..."
        az cloud set --name AzureUSGovernment

        echo "Logging in to Azure Government..."
        az login --tenant "$GOV_TENANT" --use-device-code

        echo "Now using AzureUSGovernment"
    else
        echo "Switching to Azure Commercial Cloud..."
        az cloud set --name AzureCloud

        echo "Logging in to Azure Commercial..."
        az login --tenant "$COMM_TENANT" --use-device-code

        echo "Now using AzureCloud"
    fi
}


#gcprod
alias gogcprod='echo "Setting Azure subscription..." && az account set --subscription REDACTED-SUBSCRIPTION-ID && echo "Getting AKS credentials..." && az aks get-credentials --resource-group REDACTED --name REDACTED --overwrite-existing && echo "Converting kubeconfig..." && kubelogin convert-kubeconfig -l azurecli && echo "Done!"'


#observe-dev
alias golt='echo "Setting Azure subscription..." && az account set --subscription REDACTED-SUBSCRIPTION-ID && echo "Getting AKS credentials..." && az aks get-credentials --resource-group REDACTED --name REDACTED --overwrite-existing && echo "Converting kubeconfig..." && kubelogin convert-kubeconfig -l azurecli && echo "Done!"'

#sandbox
alias gosandbox='echo "Setting Azure subscription..." && az account set --subscription REDACTED-SUBSCRIPTION-ID && echo "Getting AKS credentials..." && az aks get-credentials --resource-group REDACTED --name REDACTED --overwrite-existing && echo "Converting kubeconfig..." && kubelogin convert-kubeconfig -l azurecli && echo "Done!"'
# rbenv
#eval "$(rbenv init -)"

alias kbadpods="kubectl get pods --all-namespaces -o json | jq -r '.items[] | select(.status.phase != \"Running\" or (.status.containerStatuses[]? | select(.state.waiting.reason != null))) | \"NS:\u001b[90m \(.metadata.namespace)\u001b[0m\nPOD:\u001b[90m \(.metadata.name)\u001b[0m\nPHASE:\u001b[33m \(.status.phase)\u001b[0m\n\" + ([.status.containerStatuses[]? | \"  \u001b[34mContainer:\u001b[0m \(.name)\n    \u001b[36mState:\u001b[0m \(.state | tojson)\n    \u001b[36mRestarts:\u001b[0m \(.restartCount)\"] | join(\"\n\")) + \"\n\u001b[90m\" + (\"-\" * 60) + \"\u001b[0m\"' | sed -E -e 's/(CrashLoopBackOff|ImagePullBackOff|Error)/\x1b[31m\1\x1b[0m/g' -e 's/(Pending)/\x1b[33m\1\x1b[0m/g' -e 's/(Restarts: [5-9])/\x1b[33m\1\x1b[0m/g'"


# Added by Windsurf
export PATH="/Users/jay/.codeium/windsurf/bin:$PATH"
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# AuditIdentity Git aliases
alias git-whoami='echo "Name: $(git config user.name)" && echo "Email: $(git config user.email)"'
alias git-test-ai='echo "Testing AuditIdentity config..." && cd ~/work && mkdir -p test && cd test && git init &>/dev/null && git config user.email && cd .. && rm -rf test'
alias cdai='cd ~/work/auditidentity'


# Tmux Aliases - Modern Development Setup
alias t="tmux"
alias ta="tmux attach"
alias tl="tmux list-sessions"
alias tn="tmux new-session"
alias tk="tmux kill-session"
alias dev="~/.setup-dev-session.sh"
alias tmux-reload="tmux source ~/.tmux.conf && echo 'Tmux config reloaded!'"

# Quick tmux sessions for different projects
alias tmux-go="tmux new-session -d -s go -c ~/Code && tmux attach -t go"
alias tmux-k8s="tmux new-session -d -s k8s -c ~/Code/k8s-rbac-audit-toolkit && tmux attach -t k8s"

export PATH="$HOME/.local/bin:$PATH"

# ── Machine-local secrets and overrides (not in git) ─────────────
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
