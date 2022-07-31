# Node.js
set -x PATH $HOME/.nodebrew/current/bin $PATH

# Python
pyenv init - | source

# VSCode
alias e='code -a .'

# zoxide
zoxide init fish | source
