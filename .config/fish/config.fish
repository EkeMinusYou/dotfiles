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

# lazygit
set -x XDG_CONFIG_HOME "$HOME/.config"

# Kubernetes
kubectl completion fish | source
alias k="kubectl"

# Node.js
fish_add_path $HOME/.nodebrew/current/bin

# Terraform
alias tf="terraform"

# Python
# set -Ux PYENV_ROOT $HOME/.pyenv
# set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
# pyenv init - | source

# Go
set -gx GOPATH $HOME/go
fish_add_path $GOPATH/bin

# Java
fish_add_path /opt/homebrew/opt/openjdk@11/bin
set -gx CPPFLAGS "-I/opt/homebrew/opt/openjdk@11/include"

# VSCode
alias e='code -a .'

# zoxide
zoxide init fish | source

# gcloud
source $HOME/google-cloud-sdk/path.fish.inc

# lunarvim
fish_add_path $HOME/.local/bin