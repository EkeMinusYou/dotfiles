#!/bin/bash

brew upgrade
sheldon lock --update
gcloud components update --quiet
nvim --headless "+Lazy! sync" +qa
kubectl completion zsh > ~/.zsh/scripts/_kubectl
lovot completion zsh > ~/.zsh/scripts/_lovot
atlas completion zsh > ~/.zsh/scripts/_atlas
direnv hook zsh > ~/.zsh/scripts/_direnv
npm completion > ~/.zsh/scripts/_npm
docker completion zsh > ~/.zsh/scripts/_docker
soracom completion zsh > ~/.zsh/scripts/_soracom
$HOMEBREW_PREFIX/bin/brew shellenv > ~/.zsh/scripts/_brew

# macSKK
DOT_DIR="$HOME/src/github.com/EkeMinusYou"
cp $DOT_DIR/dotfiles/macSKK/kana-rule.conf ~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Settings/kana-rule.conf
