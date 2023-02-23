#!/bin/bash

if [ "$(uname)" == 'Linux' ]; then
  sudo apt install git
fi

# Clone dotfiles
DOT_DIR="$HOME/src/github.com/EkeMinusYou"
git clone https://github.com/EkeMinusYou/dotfiles ${DOT_DIR}/dotfiles
ln -sfn $DOT_DIR/dotfiles/.gitconfig ~/.gitconfig

# Install packages by brew
brew bundle --file "$DOT_DIR/dotfiles/Brewfile"

# Setup zsh
ln -sfn $DOT_DIR/dotfiles/.zimrc ~/.zimrc
ln -sfn $DOT_DIR/dotfiles/.zshrc ~/.zshrc
mkdir -p ~/.zsh/completion
ln -sfn $DOT_DIR/dotfiles/.zsh/completion ~/.zsh/

# lazygit
mkdir -p ~/.config/lazygit
ln -sfn $DOT_DIR/dotfiles/.config/lazygit/config.yml ~/.config/lazygit/config.yml

# Setup nvim
ln -sfn $DOT_DIR/dotfiles/.config/nvim ~/.config/

# Setup karabiner
ln -sfn $DOT_DIR/dotfiles/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
