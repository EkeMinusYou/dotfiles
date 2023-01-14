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

# Setup fish
$(brew --prefix)/opt/fzf/install
fisher install edc/bass
fisher install lgathy/google-cloud-sdk-fish-completion
ln -sfn $DOT_DIR/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
ln -sfn $DOT_DIR/dotfiles/.config/fish/functions/select_ghq_cd.fish ~/.config/fish/functions/select_ghq_cd.fish
ln -sfn $DOT_DIR/dotfiles/.config/fish/functions/fish_user_key_bindings.fish ~/.config/fish/functions/fish_user_key_bindings.fish
ln -sfn $DOT_DIR/dotfiles/.config/fish/completions/aws.fish ~/.config/fish/completions/aws.fish
ln -sfn $DOT_DIR/dotfiles/.config/fish/completions/tccli.fish ~/.config/fish/completions/tccli.fish

# lazygit
mkdir ~/.config/lazygit
ln -sfn $DOT_DIR/dotfiles/.config/lazygit/config.yml ~/.config/lazygit/config.yml

# Setup nvim
ln -sfn $DOT_DIR/dotfiles/.config/nvim ~/.config/nvim

# Setup karabiner
ln -sfn $DOT_DIR/dotfiles/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
