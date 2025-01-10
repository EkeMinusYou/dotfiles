#!/bin/bash

brew upgrade
sheldon lock --update
gcloud components update --quiet
nvim --headless "+Lazy! sync" +qa
kubectl completion zsh > ~/.zsh/local.script/_kubectl
lovot completion zsh > ~/.zsh/local.script/_lovot
atlas completion zsh > ~/.zsh/local.script/_atlas
direnv hook zsh > ~/.zsh/local.script/_direnv
npm completion > ~/.zsh/local.script/_npm
docker completion zsh > ~/.zsh/local.script/_docker
soracom completion zsh > ~/.zsh/local.script/_soracom
$HOMEBREW_PREFIX/bin/brew shellenv > ~/.zsh/local.script/_brew
