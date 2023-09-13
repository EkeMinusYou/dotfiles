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
     && ${cmd} != z
     && ${cmd} != cd
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

# lsd
alias l="ls"
alias ll="ls -la"
alias ls="lsd"

# vim
alias v="vim"
alias vim="nvim"

# Default Editor
export EDITOR=$(which nvim)

# Git
alias g="git"
alias zg='cd "$(git rev-parse --show-toplevel)"'

# lazygit
export XDG_CONFIG_HOME=$HOME/.config

# Kubernetes
alias k="kubectl"
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

# zoxide
eval "$(zoxide init zsh)"

# gcloud
test -e $HOME/google-cloud-sdk/path.zsh.inc && source $HOME/google-cloud-sdk/path.zsh.inc || true
test -e $HOME/google-cloud-sdk/completion.zsh.inc && source $HOME/google-cloud-sdk/completion.zsh.inc || true
export USE_GKE_GCLOUD_AUTH_PLUGIN=true
export CLOUDSDK_PYTHON=$(which python3.9)

# direnv
eval "$(direnv hook zsh)"
export DIRENV_LOG_FORMAT=

# tencent
export PATH=$HOME/.tencent/bin:$PATH

# tccli
complete -C 'tccli_completer' tccli

# terraform
complete -o nospace -C terraform terraform

# ghq
function ghq-fzf() {
  local src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf

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
# Before Load Plugins
# -------------------

# zsh-autocomplete
zstyle ':autocomplete:*' fzf-completion yes
zstyle ':autocomplete:*' recent-dirs zoxide
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
