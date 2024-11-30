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

# coreutils
alias ln="gln"
alias wc="gwc"

# pipe
alias -g C='| wc -l'
alias -g G='| grep'
alias -g H='| head'
alias -g L='| less'
alias -g M='| more'
alias -g T='| tail'
alias -g J='| jq'
alias -g Y='| yq'

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
alias ghs="gh api -X GET /user/starred --paginate --cache 24h | jq '.[].full_name' -r | fzf | xargs gh repo view --web"

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
alias kr="kubectl rollout"
type kubectl >/dev/null 2>&1 && source <(kubectl completion zsh)

# stern
type stern >/dev/null 2>&1 && source <(stern --completion=zsh)

# k9s
alias k9="k9s --readonly"

# Node.js
eval "$(fnm env --use-on-cd)"

# Terraform
alias tf="terraform"
alias tff="terraform fmt"
alias tfp="terraform plan"
alias tfa="terraform apply"
alias tfs="terraform state"
export TF_CLI_ARGS_plan="--parallelism=30"
export TF_CLI_ARGS_apply="--parallelism=30"

# Go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# Java
export PATH=$(brew --prefix)/opt/openjdk@11/bin:$PATH
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include"

# deno
export PATH=$HOME/.deno/bin:$PATH

# deno tools
if [ $commands[switchbot] ]; then
  source <(switchbot completions zsh)
fi

# Python
export PATH=/opt/homebrew/Cellar/python@3.8/3.8.19/Frameworks/Python.framework/Versions/3.8/bin:$PATH

# Rust
export PATH=$HOME/.cargo/bin:$PATH

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

# aqua
export PATH="$(aqua root-dir)/bin:$PATH"

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

local no_expand_commands=("ls" "ll" "ln" "wc")

function expand-alias() {
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
zstyle -e ':autocomplete:*:*' list-lines 'reply=( $(( LINES / 3 )) )'
zstyle ':autocomplete:history-*:*' list-lines 5
zstyle ':autocomplete:*' delay 0
zstyle ':autocomplete:*' min-input 1
# See: https://github.com/marlonrichert/zsh-autocomplete/issues/724
setopt INTERACTIVECOMMENTS

# -------------------
# Load Plugins
# -------------------

eval "$(sheldon source)"

# -------------------
# Starship
# -------------------

eval "$(starship init zsh)"

# -------------------
# fzf
# -------------------

eval "$(fzf --zsh)"
# catppuccin
# See: https://github.com/catppuccin/fzf
export FZF_DEFAULT_OPTS=" \
--layout=reverse \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# -------------------
# zeno.zsh
# -------------------
if [[ -n $ZENO_LOADED ]]; then
  source $ZENO_ROOT
  bindkey '^i' zeno-completion
  bindkey '^x '  zeno-insert-space
  bindkey '^x^m' accept-line
fi
