#!/bin/bash

brew upgrade
sheldon lock --update
gcloud components update --quiet
nvim --headless "+Lazy! sync" +qa

# fpath
kubectl completion zsh > ~/.zsh/fpath/_kubectl
atlas completion zsh > ~/.zsh/fpath/_atlas
docker completion zsh > ~/.zsh/fpath/_docker
soracom completion zsh > ~/.zsh/fpath/_soracom
gwq completion zsh > ~/.zsh/fpath/_gwq

# scripts
direnv hook zsh > ~/.zsh/scripts/_direnv
lovot completion zsh > ~/.zsh/scripts/_lovot
npm completion > ~/.zsh/scripts/_npm
$HOMEBREW_PREFIX/bin/brew shellenv > ~/.zsh/scripts/_brew

# macSKK
DOT_DIR="$HOME/src/github.com/EkeMinusYou"
cp $DOT_DIR/dotfiles/macSKK/kana-rule.conf ~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Settings/kana-rule.conf
