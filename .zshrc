# ------------------
# General Settings
# ------------------

bindkey -e

# ------------------
# Adding fpath
# ------------------

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

# docker
fpath=(~/.zsh/completion $fpath)

# ------------------
# Enable Completion
# ------------------

autoload -U compinit
compinit

# ------------------
# Other Settings
# ------------------

# zsh-autocomplete
zstyle ':autocomplete:*' delay 0

# suppress prompt
export LISTMAX=10000

# history

zshaddhistory() {
  local line=${1%%$'\n'}
  local cmd=${line%% *}

  # Only those that satisfy all of the following conditions are added to the history
  [[ ${#line} -ge 5
     && ${cmd} != ls
     && ${cmd} != z
     && ${cmd} != cd
     && ${cmd} != v
     && ${cmd} != vim
     && ${cmd} != nvim
     && ${cmd} != more
     && ${cmd} != less
     && ${cmd} != ping
     && ${cmd} != which
     && ${cmd} != cat
     && ${cmd} != bat
  ]]
}

# autopair
source $(brew --prefix)/share/zsh-autopair/autopair.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# lsd
alias l="ls"
alias ll="ls -l"
alias ls="lsd"

# vim
alias v="vim"
alias vim="nvim"

# Default Editor
export EDITOR=$(which nvim)

# Git
alias g="git"

# lazygit
export XDG_CONFIG_HOME=$HOME/.config

# Kubernetes
alias k="kubectl"
source <(kubectl completion zsh)

# Node.js
eval "$(fnm env --use-on-cd)"

# Terraform
alias tf="terraform"

# Go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# Java
export PATH=$(brew --prefix)/opt/openjdk@11/bin:$PATH
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include"

# VSCode
alias e='code -a .'

# zoxide
eval "$(zoxide init --no-cmd zsh)"
# Fixes https://github.com/ajeetdsouza/zoxide/issues/565
function z() {
  __zoxide_z "$@"
}

# gcloud
test -e $HOME/google-cloud-sdk/path.zsh.inc && source $HOME/google-cloud-sdk/path.zsh.inc || true
test -e $HOME/google-cloud-sdk/completion.zsh.inc && source $HOME/google-cloud-sdk/completion.zsh.inc || true
export USE_GKE_GCLOUD_AUTH_PLUGIN=true

# tencent
export PATH=$HOME/.tencent/bin:$PATH

# tccli
complete -C 'tccli_completer' tccli

# terraform
complete -C terraform terraform

# lunarvim
export PATH=$HOME/.local/bin:$PATH

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

# ------------------
# Load Plugins
# ------------------

eval "$(sheldon source)"

# ------------------
# starship
# ------------------

eval "$(starship init zsh)"
