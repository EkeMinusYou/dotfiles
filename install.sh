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

# Codex and Worktrunk use their config directories for local state.
# Keep these directories real so stow does not link runtime files into the repo.
prepare_stow_dirs() {
  mkdir -p "$HOME/.config/codex" "$HOME/.config/codex-zai" "$HOME/.config/codex-gx" "$HOME/.config/worktrunk"
}

prepare_claude_skills_dir() {
  local repo_skills="$DOT_REPO/base/.config/claude/skills"
  local user_skills="$HOME/.config/claude/skills"

  if [ -L "$user_skills" ]; then
    if [ "$(cd "$user_skills" && pwd -P)" != "$(cd "$repo_skills" && pwd -P)" ]; then
      log "cannot migrate skills symlink pointing outside this repo: $user_skills"
      exit 1
    fi
    rm "$user_skills"
  fi

  mkdir -p "$user_skills"
  if [ -e "$repo_skills/synced" ] || [ -L "$repo_skills/synced" ]; then
    if [ -e "$user_skills/synced" ] || [ -L "$user_skills/synced" ]; then
      log "cannot move synced skills: destination already exists: $user_skills/synced"
      exit 1
    fi
    mv "$repo_skills/synced" "$user_skills/synced"
  fi
}

apply_stow_packages() {
  local os_package="$1"
  stow -v --ignore='(^|/)\.DS_Store$' -d "$DOT_REPO" -t "$HOME" base "$os_package"
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

# plist では ~ が展開されないため $HOME を埋め込んで生成する
setup_yaskkserv2_launch_agent() {
  local label="com.github.wachikun.yaskkserv2"
  local plist="$HOME/Library/LaunchAgents/$label.plist"

  mkdir -p "$(dirname "$plist")"
  cat >"$plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>$label</string>
  <key>ProgramArguments</key>
  <array>
    <string>$HOME/.yaskkserv2/bin/yaskkserv2</string>
    <string>--no-daemonize</string>
    <string>--google-suggest</string>
    <string>--google-cache-filename=$HOME/.yaskkserv2/yaskkserv2.cache</string>
    <string>$HOME/.yaskkserv2/dictionary.yaskkserv2</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
  <key>KeepAlive</key>
  <true/>
  <key>StandardErrorPath</key>
  <string>$HOME/.yaskkserv2/yaskkserv2.log</string>
</dict>
</plist>
EOF

  launchctl bootout "gui/$(id -u)/$label" 2>/dev/null || true
  launchctl bootstrap "gui/$(id -u)" "$plist"
}

setup_macos_extras() {
  # 公式リリースに arm64 版がないためソースからビルドする
  if ! command -v cargo >/dev/null 2>&1; then
    brew install rust
  fi
  cargo install --locked --force --git https://github.com/wachikun/yaskkserv2 --root "$HOME/.yaskkserv2" \
    --bin yaskkserv2 --bin yaskkserv2_make_dictionary
  cp "$DOT_REPO/macSKK/dictionary.yaskkserv2" "$HOME/.yaskkserv2/dictionary.yaskkserv2"
  setup_yaskkserv2_launch_agent

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
  prepare_stow_dirs
  prepare_claude_skills_dir
  apply_stow_packages "$os_package"

  mkdir -p "$HOME/.zsh/scripts"

  if [ "$OS" = "Darwin" ]; then
    setup_macos_extras
  fi

  log "done"
}

main "$@"
