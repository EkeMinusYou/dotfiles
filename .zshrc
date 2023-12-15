# -------------------
# General Settings
# -------------------

bindkey -e

# --------------------
# Adding fpath
# --------------------

# homebrew
case ${OSTYPE} in
  darwin*)
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
  linux*)
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    ;;
esac

if type brew &>/dev/null
then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

# import completions
fpath=(~/.zsh/completion $fpath)

# -------------------
# Enable Completion
# -------------------

autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# -------------------
# Add Zsh Hook
# -------------------

autoload -Uz add-zsh-hook

# -------------------
# Recent Directories
# -------------------
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-prune parent

autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

# -------------------
# Other Settings
# -------------------

# suppress prompt
export LISTMAX=10000

# history
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_NO_STORE
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt AUTO_PUSHD
setopt AUTO_CD
setopt PUSHD_IGNORE_DUPS

zshaddhistory() {
  local line=${1%%$'\n'}
  local cmd=${line%% *}

  # Only those that satisfy all of the following conditions are added to the history
  [[ ${#line} -ge 5
     && ${cmd} != ls
     && ${cmd} != cd
     && ${cmd} != cdr
     && ${cmd} != more
     && ${cmd} != less
     && ${cmd} != ping
     && ${cmd} != which
  ]]
}

# autopair
source $(brew --prefix)/share/zsh-autopair/autopair.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# coreutils
alias ln="gln"
alias wc="gwc"

# pipe
alias -g G='| grep'
alias -g C='| wc -l'
alias -g T='| tail'
alias -g H='| head'
alias -g L='| less'
alias -g M='| more'

# cd
alias c="cd"
alias ...="cd ../.."

# lsd
alias l="ls"
alias ll="ls -la"
alias ls="lsd"

# vim
alias v="nvim"
alias vim="nvim"

# Default Editor
export EDITOR=$(which nvim)

# XDG
export XDG_CONFIG_HOME=$HOME/.config

# Git
alias g="git"
alias cr='cd "$(git rev-parse --show-toplevel)"'
alias ga="git add"
alias gpl="git pull"
alias gplr="git pull --rebase origin"
alias gst="git stash -u"
alias gsta="git stash apply"
alias gcm="git commit -m"
alias gco="git checkout"
alias gsw="git switch"
alias gps="git push"
alias gpsf="git push --force-with-lease"
alias glgo="git log --oneline"
alias gcom="git switch \$(gh repo view --json defaultBranchRef --jq .defaultBranchRef.name)"
alias gplrm="git pull --rebase origin \$(gh repo view --json defaultBranchRef --jq .defaultBranchRef.name)"

# GitHub
alias ghb="gh browse"
alias ghpw="gh pr view --web"
alias ghpc="gh pr create"

# Kubernetes
alias k="kubectl"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kl="kubectl logs"
alias kt="kubectl top"
type kubectl >/dev/null 2>&1 && source <(kubectl completion zsh)

# Node.js
eval "$(fnm env --use-on-cd)"

# Terraform
alias tf="terraform"
export TF_CLI_ARGS_plan="--parallelism=30"
export TF_CLI_ARGS_apply="--parallelism=30"

# Go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# Java
export PATH=$(brew --prefix)/opt/openjdk@11/bin:$PATH
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include"

# VSCode
alias e='code -a .'

# gcloud
test -e $HOME/google-cloud-sdk/path.zsh.inc && source $HOME/google-cloud-sdk/path.zsh.inc || true
test -e $HOME/google-cloud-sdk/completion.zsh.inc && source $HOME/google-cloud-sdk/completion.zsh.inc || true
export USE_GKE_GCLOUD_AUTH_PLUGIN=true
export CLOUDSDK_PYTHON=$(which python3.9)

# direnv
type direnv >/dev/null 2>&1 && source <(direnv hook zsh)
export DIRENV_LOG_FORMAT=

# tencent
export PATH=$HOME/.tencent/bin:$PATH

# tccli
complete -C 'tccli_completer' tccli

# terraform
complete -o nospace -C terraform terraform

# iterm2
test -e $HOME/.iterm2_shell_integration.zsh && source $HOME/.iterm2_shell_integration.zsh || true

# wsl
export LD_LIBRARY_PATH=/usr/lib/wsl/lib:$LD_LIBRARY_PATH

# lovot
export PATH=$HOME/.lovot/bin:$PATH
if [ $commands[lovot] ]; then
  source <(lovot completion zsh)
fi

# -------------------
# Functions
# -------------------

function ghq-fzf() {
  local src=$(ghq list | fzf --height 40% --reverse)
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf

function cdr-fzf() {
  local src=$(cdr -l | awk '{print $2}' | fzf --height 40% --reverse)
  if [ -n "$src" ]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N cdr-fzf
bindkey '^z' cdr-fzf

function expand-alias() {
  local no_expand_commands=("ls" "ll" "ln" "wc" "rm")

  local words=(${(z)LBUFFER})
  local word="${words[-1]}"
  if [[ ! "${no_expand_commands[(r)$word]}" ]]; then
    zle _expand_alias
  fi
  zle self-insert
}
zle -N expand-alias
bindkey -M main ' ' expand-alias

function expand-alias-accept-line() {
  local no_expand_commands=("ls" "ll" "ln" "wc" "rm")

  local words=(${(z)LBUFFER})
  local word="${words[-1]}"
  if [[ ! "${no_expand_commands[(r)$word]}" ]]; then
    zle _expand_alias
  fi
  zle .reset-prompt
  zle .accept-line
}
zle -N accept-line expand-alias-accept-line

function paste-as-yank() {
  BUFFER=$(pbpaste) 
  CURSOR=$#BUFFER 
  zle redisplay
}
zle -N paste-as-yank
bindkey "^y" paste-as-yank

# -------------------
# Before Load Plugins
# -------------------

# zsh-autocomplete
zstyle ':autocomplete:*' fzf-completion yes
zstyle ':autocomplete:*' list-lines 50
zstyle ':autocomplete:history-*:*' list-lines 5
zstyle ':autocomplete:*' delay 0
zstyle ':autocomplete:*' min-input 0

# -------------------
# Load Plugins
# -------------------

eval "$(sheldon source)"

# -------------------
# Starship
# -------------------

eval "$(starship init zsh)"
