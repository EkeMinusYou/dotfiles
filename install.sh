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

# gitignore
mkdir -p ~/.config/git
ln -sfn $DOT_DIR/dotfiles/.config/git/ignore ~/.config/git/ignore

# Setup zsh
ln -sfn $DOT_DIR/dotfiles/.zshrc ~/.zshrc
mkdir -p ~/.zsh/
ln -sfn $DOT_DIR/dotfiles/.zsh/completion ~/.zsh/

# lazygit
mkdir -p ~/.config/lazygit
ln -sfn $DOT_DIR/dotfiles/.config/lazygit/config.yml ~/.config/lazygit/config.yml

# Setup sheldon
mkdir -p ~/.config/sheldon
ln -sfn $DOT_DIR/dotfiles/.config/sheldon/plugins.toml ~/.config/sheldon/plugins.toml

# Setup nvim
ln -sfn $DOT_DIR/dotfiles/.config/nvim ~/.config/

# Setup snippets
ln -sfn $DOT_DIR/dotfiles/.vsnip ~/.vsnip

# Setup GitHub CLI
mkdir -p ~/.config/gh
ln -sfn $DOT_DIR/dotfiles/.config/gh/config.yml ~/.config/gh/config.yml

# Setup starship
ln -sfn $DOT_DIR/dotfiles/.config/starship.toml ~/.config/starship.toml

# Setup karabiner
mkdir -p ~/.config/karabiner
ln -sfn $DOT_DIR/dotfiles/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json

# Setup WezTerm
mkdir -p ~/.config/wezterm
ln -sfn $DOT_DIR/dotfiles/.config/wezterm ~/.config/

# Setup gh dash
mkdir -p ~/.config/gh-dash
ln -sfn $DOT_DIR/dotfiles/.config/gh-dash/config.yml ~/.config/gh-dash/config.yml

if [ `uname` == 'Darwin']; then
  # Setup yabai and skhd
  mkdir -p ~/.config/yabai
  ln -sfn $DOT_DIR/dotfiles/.config/yabai/yabairc ~/.config/yabai/yabairc
  mkdir -p ~/.config/skhd
  ln -sfn $DOT_DIR/dotfiles/.config/skhd/skhdrc ~/.config/skhd/skhdrc
  # Setup macSKK
  ln -sfn $DOT_DIR/dotfiles/macSKK/kana-rule.conf ~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Settings/kana-rule.conf
  ln -sfn ~/.skk/skk-jisyo.utf8 ~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Dictionaries/skk-jisyo.utf8
fi
