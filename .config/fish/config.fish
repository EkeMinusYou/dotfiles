# Suppress Welcome message
set fish_greeting

# Vim
alias vim="nvim"

# Default Editor
set -x EDITOR $(which nvim)

# Git
alias g="git"

# Kubernetes
kubectl completion fish | source
alias k="kubectl"

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
if test (uname -s) = "Darwin"
	source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc'
else
  source $HOME/google-cloud-sdk/path.fish.inc
end

# gRPC
set -x PATH $PATH:$(go env GOPATH)/bin $PATH
