# Suppress Welcome message
set fish_greeting

# Homebrew
set PATH /opt/homebrew/bin $PATH
if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

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
set -gx PATH $HOME/.nodebrew/current/bin $PATH

# Terraform
alias tf="terraform"

# Python
# set -Ux PYENV_ROOT $HOME/.pyenv
# set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
# pyenv init - | source

# Go
set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin

# VSCode
alias e='code -a .'

# zoxide
zoxide init fish | source

# gcloud
source $HOME/google-cloud-sdk/path.fish.inc

# lunarvim
set -gx PATH $HOME/.local/bin $PATH