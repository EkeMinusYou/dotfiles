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
mkdir -p ~/.zsh/scripts

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

# Setup cz-git
ln -sfn $DOT_DIR/dotfiles/.czrc ~/.czrc

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

# Setup yazi
ln -sfn $DOT_DIR/dotfiles/.config/yazi ~/.config/

# Setup aqua
ln -sfn $DOT_DIR/dotfiles/.config/aqua ~/.config/

# ghostty
ln -sfn $DOT_DIR/dotfiles/.config/ghostty ~/.config/

# zellij
ln -sfn $DOT_DIR/dotfiles/.config/zellij ~/.config/

# alacritty
ln -sfn $DOT_DIR/dotfiles/.config/alacritty ~/.config

# typos
ln -sfn $DOT_DIR/dotfiles/.config/typos ~/.config

# dive
ln -sfn $DOT_DIR/dotfiles/.config/dive ~/.config

# moxide
ln -sfn $DOT_DIR/dotfiles/.config/moxide ~/.config

# direnv
ln -sfn $DOT_DIR/dotfiles/.config/direnv ~/.config

# goose
ln -sfn $DOT_DIR/dotfiles/.config/goose ~/.config/

# opencode
ln -sfn $DOT_DIR/dotfiles/.opencode.json ~/

# claude
ln -fn $DOT_DIR/dotfiles/.config/claude/settings.json ~/.config/claude/settings.json

# gelf
ln -fn $DOT_DIR/dotfiles/.config/gelf/gelf.yaml ~/.config/gelf/gelf.yaml

# devcontainer
mkdir -p ~/.config/devcontainer
ln -sfn $DOT_DIR/dotfiles/.config/devcontainer/claude ~/.config/devcontainer

# gwq
ln -sfn $DOT_DIR/dotfiles/.config/gwq/config.toml ~/.config/gwq/config.toml

if [ `uname` == 'Darwin' ]; then
  # yaskkserv2
  mkdir -p ~/.yaskkserv2/bin
  YASKKSERV2_VERSION="0.1.7"
  YASKKSERV2_ARCHIVE="yaskkserv2-$YASKKSERV2_VERSION-x86_64-apple-darwin.tar.gz"

  if [ ! -z "$YASKKSERV2_ARCHIVE" ]; then
    curl -L -o /tmp/$YASKKSERV2_ARCHIVE "https://github.com/wachikun/yaskkserv2/releases/download/$YASKKSERV2_VERSION/$YASKKSERV2_ARCHIVE"
    tar -xzf /tmp/$YASKKSERV2_ARCHIVE -C ~/.yaskkserv2 --strip-components=1
    mv ~/.yaskkserv2/yaskkserv2 ~/.yaskkserv2/bin/yaskkserv2
    mv ~/.yaskkserv2/yaskkserv2_make_dictionary ~/.yaskkserv2/bin/yaskkserv2_make_dictionary
    cp ./macSKK/dictionary.yaskkserv2 ~/.yaskkserv2/dictionary.yaskkserv2
    rm /tmp/$YASKKSERV2_ARCHIVE
  fi

  # Setup yabai and skhd
  mkdir -p ~/.config/yabai
  ln -sfn $DOT_DIR/dotfiles/.config/yabai/yabairc ~/.config/yabai/yabairc
  mkdir -p ~/.config/skhd
  ln -sfn $DOT_DIR/dotfiles/.config/skhd/skhdrc ~/.config/skhd/skhdrc
  # Setup macSKK
  ln -sfn $DOT_DIR/dotfiles/macSKK/kana-rule.conf ~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Settings/kana-rule.conf
  ln -sfn ~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Dictionaries/skk-jisyo.utf8 ~/.skk/skk-jisyo.utf8
fi
