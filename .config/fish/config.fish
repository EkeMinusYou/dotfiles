# Suppress Welcome message
set fish_greeting

# Git
alias g="git"

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

# gcloud
if test (uname -s) = "Darwin"
	source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc'
else
  source $HOME/google-cloud-sdk/path.fish.inc
end