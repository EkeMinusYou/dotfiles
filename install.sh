#!/bin/bash

if [ `uname` == 'Linux' ]; then
  sudo apt install git
fi

# Clone dotfiles
DOT_DIR="$HOME/src/github.com/EkeMinusYou"
git clone https://github.com/EkeMinusYou/dotfiles ${DOT_DIR}/dotfiles
ln -sfn $DOT_DIR/dotfiles/.gitconfig ~/.gitconfig

if [ `uname` == 'Darwin' ]; then
  ln -sfn $DOT_DIR/dotfiles/.gitconfig-mac ~/.gitconfig-os
elif [ `uname` = "Linux" ]; then
  ln -sfn $DOT_DIR/dotfiles/.gitconfig-linux ~/.gitconfig-os
fi

# Setup zsh
ln -sfn $DOT_DIR/dotfiles/.zimrc ~/.zimrc
ln -sfn $DOT_DIR/dotfiles/.zshrc ~/.zshrc
mkdir -p ~/.zsh/
ln -sfn $DOT_DIR/dotfiles/.zsh/completion ~/.zsh/

# fzf
$(brew --prefix)/opt/fzf/install

# lazygit
mkdir -p ~/.config/lazygit
ln -sfn $DOT_DIR/dotfiles/.config/lazygit/config.yml ~/.config/lazygit/config.yml

# Setup sheldon
mkdir -p ~/.config/sheldon
ln -sfn $DOT_DIR/dotfiles/.config/sheldon/plugins.toml ~/.config/sheldon/plugins.toml

# Setup nvim
ln -sfn $DOT_DIR/dotfiles/.config/nvim ~/.config/

# Setup starship
ln -sfn $DOT_DIR/dotfiles/.config/starship.toml ~/.config/starship.toml

# Setup karabiner
mkdir -p ~/.config/karabiner
ln -sfn $DOT_DIR/dotfiles/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json

# Setup WezTerm
mkdir -p ~/.config/wezterm
ln -sfn $DOT_DIR/dotfiles/.config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua

if [ `uname` == 'Darwin']; then
  # Setup yabai and skhd
  mkdir -p ~/.config/yabai
  ln -sfn $DOT_DIR/dotfiles/.config/yabai/yabairc ~/.config/yabai/yabairc
  mkdir -p ~/.config/skhd
  ln -sfn $DOT_DIR/dotfiles/.config/skhd/skhdrc ~/.config/skhd/skhdrc
fi



# Install packages by brew
brew bundle --file "$DOT_DIR/dotfiles/Brewfile"
