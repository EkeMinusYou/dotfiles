#!/usr/bin/env bash

set -euo pipefail

OS="$(uname)"
DOT_OWNER="EkeMinusYou"
DOT_DIR="$HOME/src/github.com/$DOT_OWNER"
DOT_REPO="$DOT_DIR/dotfiles"
DOT_GIT_URL="https://github.com/$DOT_OWNER/dotfiles"

log() {
  printf '[install] %s\n' "$1"
}

require_cmd() {
  local cmd="$1"
  if command -v "$cmd" >/dev/null 2>&1; then
    return 0
  fi
  log "command not found: $cmd"
  exit 1
}

ensure_prerequisites() {
  if [ "$OS" = "Linux" ]; then
    if ! command -v git >/dev/null 2>&1 || ! command -v stow >/dev/null 2>&1; then
      sudo apt update
      sudo apt install -y git stow
    fi
  elif [ "$OS" = "Darwin" ]; then
    require_cmd brew
    if ! command -v git >/dev/null 2>&1; then
      brew install git
    fi
    if ! command -v stow >/dev/null 2>&1; then
      brew install stow
    fi
  else
    log "unsupported OS: $OS"
    exit 1
  fi
}

prepare_repo() {
  mkdir -p "$DOT_DIR"
  if [ -d "$DOT_REPO/.git" ]; then
    log "dotfiles repo already exists. pulling latest changes."
    git -C "$DOT_REPO" pull --ff-only
    return 0
  fi

  if [ -e "$DOT_REPO" ]; then
    log "path exists but is not a git repository: $DOT_REPO"
    exit 1
  fi

  log "cloning dotfiles repository."
  git clone "$DOT_GIT_URL" "$DOT_REPO"
}

get_os_package() {
  if [ "$OS" = "Darwin" ]; then
    echo "base-mac"
  else
    echo "base-linux"
  fi
}

apply_stow_packages() {
  local os_package="$1"
  stow -v -d "$DOT_REPO" -t "$HOME" base "$os_package"
}

link_path() {
  local src="$1"
  local dst="$2"

  if [ ! -e "$src" ] && [ ! -L "$src" ]; then
    log "skip: $src not found"
    return 0
  fi

  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    rm -f "$dst"
  fi
  ln -s "$src" "$dst"
}

setup_macos_extras() {
  mkdir -p "$HOME/.yaskkserv2/bin"
  local yaskkserv2_version="0.1.7"
  local yaskkserv2_archive="yaskkserv2-$yaskkserv2_version-x86_64-apple-darwin.tar.gz"
  local archive_path="/tmp/$yaskkserv2_archive"

  curl -L -o "$archive_path" "https://github.com/wachikun/yaskkserv2/releases/download/$yaskkserv2_version/$yaskkserv2_archive"
  tar -xzf "$archive_path" -C "$HOME/.yaskkserv2" --strip-components=1
  mv "$HOME/.yaskkserv2/yaskkserv2" "$HOME/.yaskkserv2/bin/yaskkserv2"
  mv "$HOME/.yaskkserv2/yaskkserv2_make_dictionary" "$HOME/.yaskkserv2/bin/yaskkserv2_make_dictionary"
  cp "$DOT_REPO/macSKK/dictionary.yaskkserv2" "$HOME/.yaskkserv2/dictionary.yaskkserv2"
  rm -f "$archive_path"

  link_path "$DOT_REPO/macSKK/kana-rule.conf" "$HOME/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Settings/kana-rule.conf"
  link_path "$HOME/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Dictionaries/skk-jisyo.utf8" "$HOME/.skk/skk-jisyo.utf8"
}

main() {
  ensure_prerequisites
  require_cmd git
  require_cmd stow

  prepare_repo
  local os_package
  os_package="$(get_os_package)"
  apply_stow_packages "$os_package"

  mkdir -p "$HOME/.zsh/scripts"

  if [ "$OS" = "Darwin" ]; then
    setup_macos_extras
  fi

  log "done"
}

main "$@"
