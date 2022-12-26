#!/bin/bash

if [ "$(uname)" == 'Linux' ]; then
  sudo apt install git
  test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
  test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile
fi

# Clone dotfiles
DOT_DIR="$HOME/src/github.com/EkeMinusYou"
git clone https://github.com/EkeMinusYou/dotfiles ${DOT_DIR}/dotfiles
ln -sfn $DOT_DIR/dotfiles/.gitconfig ~/.gitconfig

# Install packages by brew
brew bundle --file "$DOT_DIR/dotfiles/Brewfile"

# Setup fish
$(brew --prefix)/opt/fzf/install
fisher install edc/bass
fisher install lgathy/google-cloud-sdk-fish-completion
ln -sfn $DOT_DIR/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
ln -sfn $DOT_DIR/dotfiles/.config/fish/functions/select_ghq_cd.fish ~/.config/fish/functions/select_ghq_cd.fish
ln -sfn $DOT_DIR/dotfiles/.config/fish/functions/fish_user_key_bindings.fish ~/.config/fish/functions/fish_user_key_bindings.fish
ln -sfn $DOT_DIR/dotfiles/.config/fish/completions/aws.fish ~/.config/fish/completions/aws.fish
ln -sfn $DOT_DIR/dotfiles/.config/fish/completions/tccli.fish ~/.config/fish/completions/tccli.fish
ln -sfn $DOT_DIR/dotfiles/.bashrc ~/.bashrc
ln -sfn $DOT_DIR/dotfiles/.bash_profile ~/.bash_profile

# Setup nvim
curl -fLo ~/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim
ln -sfn $DOT_DIR/dotfiles/.config/nvim ~/.config/nvim

# Setup karabiner
ln -sfn $DOT_DIR/dotfiles/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
