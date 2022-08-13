# Suppress Welcome message
set fish_greeting

# Node.js
set -x PATH $HOME/.nodebrew/current/bin $PATH

# Python
# set -x PYENV_ROOT $HOME/.pyenv
# set -x PATH  $PYENV_ROOT/bin $PATH
# pyenv init - | source

# VSCode
alias e='code -a .'

# zoxide
zoxide init fish | source

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.fish.inc' ]; . '$HOME/google-cloud-sdk/path.fish.inc'; end
