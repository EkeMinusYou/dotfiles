# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install git

# Clone dotfiles
DOT_DIR="$HOME/src/dotfiles"
git clone https://github.com/EkeMinusYou/dotfiles ${DOT_DIR}

# Install packages by brew
brew bundle --file "$DOT_DIR/Brewfile"

# Setup fish
$(brew --prefix)/opt/fzf/install
ln -sf $DOT_DIR/.config/fish/config.fish ~/.config/fish/config.fish
ln -sf $DOT_DIR/.config/fish/functions/select_ghq_cd.fish ~/.config/fish/functions/select_ghq_cd.fish
ln -sf $DOT_DIR/.config/fish/functions/fish_user_key_bindings.fish ~/.config/fish/functions/fish_user_key_bindings.fish

# Setup neovim
ln -sf $DOT_DIR/.config/nvim/init.vim ~/.config/nvim/init.vim