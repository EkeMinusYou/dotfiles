# Suppress Welcome message
set fish_greeting

# Git
alias g="git"

# Node.js
set -x PATH $HOME/.nodebrew/current/bin $PATH

# Python
# set -Ux PYENV_ROOT $HOME/.pyenv
# set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
# pyenv init - | source

# protoc compiler
set -x PATH $PATH:$(go env GOPATH)/bin $PATH

# VSCode
alias e='code -a .'

# zoxide
zoxide init fish | source

# gcloud
source $HOME/google-cloud-sdk/path.fish.inc