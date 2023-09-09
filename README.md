## dotfiles

EkeMinusYou's Dotfiles

<img width="1904" alt="Screenshot 2023-02-07 at 23 56 02" src="https://user-images.githubusercontent.com/41781157/217281141-c6572aef-7cef-4faa-b602-05ec87684a3f.png">

## Pre-Setup

install

- [Homebrew](https://brew.sh/)

### Usage

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/EkeMinusYou/dotfiles/main/install.sh)"
```

#### Install Brew Packages

```bash
brew bundle --file "$HOME/src/github.com/EkeMinusYou/dotfiles/BrewfileEssential"
```

```bash
brew bundle --file "$HOME/src/github.com/EkeMinusYou/dotfiles/Brewfile"
```

#### Setup fzf

```bash
$(brew --prefix)/opt/fzf/install
```

### Contents

- Brewfile
- zsh setting
- Git config
- Neovim setting

### Shell

- zsh - shell
- [fzf](https://github.com/junegunn/fzf) - fuzzy finder
- [zoxide](https://github.com/ajeetdsouza/zoxide) - smarter cd command

### Version Manager

- fnm - Node.js
