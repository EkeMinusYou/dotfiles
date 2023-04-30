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
# Initialize zim
# ------------------

setopt HIST_IGNORE_ALL_DUPS
bindkey -e
setopt CORRECT
WORDCHARS=${WORDCHARS//[\/]}
zstyle ':zim:input' double-dot-expand yes
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

bindkey $terminfo[kcuu1] history-substring-search-up
bindkey $terminfo[kcud1] history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# ------------------
# User Settings
# ------------------

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

# Python
# set -Ux PYENV_ROOT $HOME/.pyenv
# set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
# pyenv init - | source

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

# tccli
complete -C 'tccli_completer' tccli

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
if [ $commands[lovot] ]; then
  source <(lovot completion zsh)
fi
