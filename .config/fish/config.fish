# Suppress Welcome message
set fish_greeting

# Git
alias g="git"
alias gpr="git pull --rebase origin"
alias gcf="git commit --fixup HEAD"

# Node.js
set -x PATH $HOME/.nodebrew/current/bin $PATH

# Terraform
alias tf="terraform"

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