# Suppress Welcome message
set fish_greeting

# Node.js
set -x PATH $HOME/.nodebrew/current/bin $PATH

# Python
# set -x PYENV_ROOT $HOME/.pyenv
# set -x PATH  $PYENV_ROOT/bin $PATH
# pyenv init - | source

# protoc compiler
set -x PATH $PATH:$(go env GOPATH)/bin $PATH

# VSCode
alias e='code -a .'

# zoxide
zoxide init fish | source

# The next line updates PATH for the Google Cloud SDK.
. $HOME/google-cloud-sdk/path.fish.inc
