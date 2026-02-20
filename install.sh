#!/bin/bash

if [ `uname` == 'Linux' ]; then
  sudo apt install git
fi

# Clone dotfiles
DOT_DIR="$HOME/src/github.com/EkeMinusYou"
git clone https://github.com/EkeMinusYou/dotfiles ${DOT_DIR}/dotfiles

link_path() {
  local src="$1"
  local dst="$2"

  if [ ! -e "$src" ] && [ ! -L "$src" ]; then
    echo "skip: $src not found"
    return 0
  fi

  mkdir -p "$(dirname "$dst")"
  if [ -d "$dst" ] && [ ! -L "$dst" ]; then
    echo "skip: $dst exists and is a directory"
    return 0
  fi
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    rm -f "$dst"
  fi
  ln -s "$src" "$dst"
}

link_path "$DOT_DIR/dotfiles/.gitconfig" "$HOME/.gitconfig"

if [ `uname` == 'Darwin' ]; then
  link_path "$DOT_DIR/dotfiles/.gitconfig-mac" "$HOME/.gitconfig-os"
elif [ `uname` = "Linux" ]; then
  link_path "$DOT_DIR/dotfiles/.gitconfig-linux" "$HOME/.gitconfig-os"
fi

# gitignore
mkdir -p ~/.config/git
link_path "$DOT_DIR/dotfiles/.config/git/ignore" "$HOME/.config/git/ignore"

# Setup zsh
link_path "$DOT_DIR/dotfiles/.zshrc" "$HOME/.zshrc"
mkdir -p ~/.zsh/
mkdir -p ~/.zsh/scripts

# lazygit
mkdir -p ~/.config/lazygit
link_path "$DOT_DIR/dotfiles/.config/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

# Setup sheldon
mkdir -p ~/.config/sheldon
link_path "$DOT_DIR/dotfiles/.config/sheldon/plugins.toml" "$HOME/.config/sheldon/plugins.toml"

# Setup nvim
link_path "$DOT_DIR/dotfiles/.config/nvim" "$HOME/.config/nvim"

# Setup snippets
link_path "$DOT_DIR/dotfiles/.vsnip" "$HOME/.vsnip"

# Setup GitHub CLI
mkdir -p ~/.config/gh
link_path "$DOT_DIR/dotfiles/.config/gh/config.yml" "$HOME/.config/gh/config.yml"

# Setup cz-git
link_path "$DOT_DIR/dotfiles/.czrc" "$HOME/.czrc"

# Setup starship
link_path "$DOT_DIR/dotfiles/.config/starship.toml" "$HOME/.config/starship.toml"

# Setup karabiner
mkdir -p ~/.config/karabiner
link_path "$DOT_DIR/dotfiles/.config/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"

# Setup WezTerm
link_path "$DOT_DIR/dotfiles/.config/wezterm" "$HOME/.config/wezterm"

# Setup gh dash
mkdir -p ~/.config/gh-dash
link_path "$DOT_DIR/dotfiles/.config/gh-dash/config.yml" "$HOME/.config/gh-dash/config.yml"

# Setup yazi
link_path "$DOT_DIR/dotfiles/.config/yazi" "$HOME/.config/yazi"

# Setup aqua
link_path "$DOT_DIR/dotfiles/.config/aqua" "$HOME/.config/aqua"

# ghostty
link_path "$DOT_DIR/dotfiles/.config/ghostty" "$HOME/.config/ghostty"

# zellij
link_path "$DOT_DIR/dotfiles/.config/zellij" "$HOME/.config/zellij"

# alacritty
link_path "$DOT_DIR/dotfiles/.config/alacritty" "$HOME/.config/alacritty"

# typos
link_path "$DOT_DIR/dotfiles/.config/typos" "$HOME/.config/typos"

# dive
link_path "$DOT_DIR/dotfiles/.config/dive" "$HOME/.config/dive"

# moxide
link_path "$DOT_DIR/dotfiles/.config/moxide" "$HOME/.config/moxide"

# direnv
link_path "$DOT_DIR/dotfiles/.config/direnv" "$HOME/.config/direnv"

# goose
link_path "$DOT_DIR/dotfiles/.config/goose" "$HOME/.config/goose"

# opencode
link_path "$DOT_DIR/dotfiles/.opencode.json" "$HOME/.opencode.json"

# claude
link_path "$DOT_DIR/dotfiles/.config/claude/settings.json" "$HOME/.config/claude/settings.json"
link_path "$DOT_DIR/dotfiles/.config/claude/CLAUDE.md" "$HOME/.config/claude/CLAUDE.md"

# claude.privatge
link_path "$DOT_DIR/dotfiles/.config/claude.private/settings.json" "$HOME/.config/claude.private/settings.json"
link_path "$DOT_DIR/dotfiles/.config/claude.private/CLAUDE.md" "$HOME/.config/claude.private/CLAUDE.md"

# gelf
link_path "$DOT_DIR/dotfiles/.config/gelf/gelf.yaml" "$HOME/.config/gelf/gelf.yaml"

# devcontainer
mkdir -p ~/.config/devcontainer
link_path "$DOT_DIR/dotfiles/.config/devcontainer/claude" "$HOME/.config/devcontainer/claude"

# gwq
link_path "$DOT_DIR/dotfiles/.config/gwq/config.toml" "$HOME/.config/gwq/config.toml"

# codex
mkdir -p ~/.codex
link_path "$DOT_DIR/dotfiles/.codex/AGENTS.md" "$HOME/.codex/AGENTS.md"
link_path "$DOT_DIR/dotfiles/.codex/config.toml" "$HOME/.codex/config.toml"
link_path "$DOT_DIR/dotfiles/.codex/rules" "$HOME/.codex/rules"

# aerospace
link_path "$DOT_DIR/dotfiles/.config/aerospace" "$HOME/.config/aerospace"

# octorus
link_path "$DOT_DIR/dotfiles/.config/octorus" "$HOME/.config/octorus"

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

  # Setup macSKK
  link_path "$DOT_DIR/dotfiles/macSKK/kana-rule.conf" "$HOME/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Settings/kana-rule.conf"
  link_path "$HOME/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Dictionaries/skk-jisyo.utf8" "$HOME/.skk/skk-jisyo.utf8"
fi
