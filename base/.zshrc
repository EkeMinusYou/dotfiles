# -------------------
# Profiling
# -------------------

# zmodload zsh/zprof && zprof

# -------------------
# General Settings
# -------------------

typeset -U path fpath
bindkey -e

# -------------------
# Homebrew Settings
# -------------------

export HOMEBREW_NO_VERIFY_ATTESTATIONS=1
case ${OSTYPE} in
  darwin*)
    export HOMEBREW_PREFIX="/opt/homebrew"
    export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
    # macOS 標準の curl が読む /etc/ssl/cert.pem には eMudhra 問題のルート証明書が残っているため、Homebrew の証明書リストを使う
    export CURL_CA_BUNDLE="$HOMEBREW_PREFIX/etc/ca-certificates/cert.pem"
    ;;
  linux*)
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
    export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew"
    ;;
esac
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export XDG_CONFIG_HOME=$HOME/.config
export NPM_CONFIG_PREFIX=${XDG_DATA_HOME:-$HOME/.local/share}/npm
export GOPATH=$HOME/go
# Set the final search order once so later changes do not invalidate command hashes.
path=(
  "$HOME/.local/bin"
  "$HOME/.yaskkserv2/bin"
  "$HOME/.lovot/bin"
  "$HOME/.tencent/bin"
  "$HOME/.cargo/bin"
  /opt/homebrew/Cellar/python@3.8/3.8.19/Frameworks/Python.framework/Versions/3.8/bin
  "$HOME/.bun/bin"
  "$HOME/.deno/bin"
  "$HOMEBREW_PREFIX/opt/openjdk@21/bin"
  "$GOPATH/bin"
  "$NPM_CONFIG_PREFIX/bin"
  "${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin"
  "$HOMEBREW_PREFIX/bin"
  "$HOMEBREW_PREFIX/sbin"
  "${path[@]}"
)
export PATH
if [[ -n ${MANPATH-} ]]; then
  export MANPATH="${MANPATH%"${MANPATH##*[!:]}"}"
  export MANPATH=":${MANPATH#"${MANPATH%%[!:]*}"}"
fi
export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}"

# -------------------
# Enable Completion
# -------------------

fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $HOME/.zsh/fpath $fpath)

# Cache generated shell integrations; refresh when their inputs change.
_zsh_source_cached() {
  local name=$1
  shift
  local cache_root=${XDG_CACHE_HOME:-$HOME/.cache}
  [[ $OSTYPE == darwin* && -z $XDG_CACHE_HOME ]] && cache_root=$HOME/Library/Caches
  cache_root+=/zsh
  local cache=$cache_root/$name.zsh signature=$ZSH_VERSION saved input
  local executable=$1
  if [[ $executable != */* ]]; then
    # Populate this entry without making the commands parameter scan all of PATH.
    hash "$executable" 2>/dev/null || return
    executable=${commands[$executable]}
  fi
  local -a inputs=("$executable" "${(%):-%x}")
  if (( ${+_zsh_cache_extra_inputs} )); then
    inputs+=("${_zsh_cache_extra_inputs[@]}")
  fi
  local -A metadata
  if [[ $name == sheldon ]]; then
    inputs+=(
      "${SHELDON_CONFIG_FILE:-${SHELDON_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/sheldon}/plugins.toml}"
      "${SHELDON_DATA_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/sheldon}/plugins.lock"
    )
    signature+=":${SHELDON_PROFILE:-}"
  fi
  zmodload -F zsh/stat b:zstat
  zmodload -F zsh/files b:zf_mkdir b:zf_mv b:zf_rm
  for input in "${inputs[@]}"; do
    # zstat follows symlinks; inode changes also detect package upgrades.
    if zstat -H metadata -- "$input" 2>/dev/null; then
      signature+=":$input:$metadata[device]:$metadata[mtime]:$metadata[inode]:$metadata[size]"
    else
      signature+=":$input:missing"
    fi
  done
  signature="# $signature"
  [[ -r $cache ]] && IFS= read -r saved < "$cache"
  if [[ $saved != $signature ]]; then
    local script
    script=$(command "$@") || return
    if [[ -d $cache_root ]] || zf_mkdir -p -m 700 -- "$cache_root"; then
      local temporary=$cache.$$.${RANDOM}
      if { print -r -- "$signature"; print -r -- "$script"; } > "$temporary" &&
          zf_mv -f -- "$temporary" "$cache"; then
        if zcompile -Uz "$temporary.zwc" "$cache"; then
          zf_mv -f -- "$temporary.zwc" "$cache.zwc"
        else
          zf_rm -f -- "$cache.zwc" "$temporary.zwc"
        fi
        source "$cache"
        return
      fi
      zf_rm -f -- "$temporary"
    fi
    eval "$script"
    return
  fi
  source "$cache"
}

# Load Autocomplete before scripts register completions or custom key bindings.
# It manages compinit and queues registrations until the first prompt.
zstyle ':autocomplete:*' fzf-completion yes
zstyle -e ':autocomplete:*:*' list-lines 'reply=( $(( LINES / 3 )) )'
zstyle ':autocomplete:history-*:*' list-lines 5
zstyle ':autocomplete:*' delay 0.15
zstyle ':autocomplete:*' min-input 1
setopt INTERACTIVECOMMENTS
_zsh_source_cached sheldon "$HOMEBREW_PREFIX/bin/sheldon" source

# -------------------
# source command scripts
# -------------------

setopt null_glob
for file in $HOME/.zsh/scripts/*; do
  [ -f "$file" ] && source "$file"
done

# Generate completions on first use in each shell, reusing the binary's cache.
_zsh_lazy_completion() {
  local tool=$service
  hash "$tool" 2>/dev/null || { _default "$@"; return; }
  local executable=${commands[$tool]}
  local -a _zsh_cache_extra_inputs=()
  # Aqua's proxy stays unchanged when the selected package is upgraded.
  if [[ ${executable:A:t} == aqua-proxy ]]; then
    local target
    target=$(command aqua which "$tool") || return
    _zsh_cache_extra_inputs+=("$target")
  fi
  local -a generator=("$tool" completion zsh)
  [[ $tool == npm ]] && generator=(npm completion)
  _zsh_source_cached "completion-$tool" "${generator[@]}" || return
  local -a handler=( ${(z)${_comps[$tool]-}} )
  [[ -n ${handler[1]-} && $handler[1] != _zsh_lazy_completion ]] || return 1
  "${(@Q)handler}" "$@"
}
compdef _zsh_lazy_completion kubectl atlas docker soracom codex gxcloud lovot npm

# -------------------
# Add Zsh Hook
# -------------------

autoload -Uz add-zsh-hook

# -------------------
# Recent Directories
# -------------------
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-prune parent

autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

# -------------------
# herdr Workspace Label
# -------------------
# herdr は worktree だと worktree のディレクトリ名をワークスペース名にするので、元のリポジトリ名に揃える
# 通常のリポジトリでは herdr の自動命名に任せ、一度 rename した shell だけ以降も追従させる
_herdr_sync_workspace_label() {
  [[ -n $HERDR_WORKSPACE_ID ]] || return
  local -a dirs
  dirs=("${(@f)$(git rev-parse --path-format=absolute --git-common-dir --show-toplevel 2>/dev/null)}")
  (( ${#dirs} == 2 )) || return
  local common=$dirs[1] top=$dirs[2] name
  if [[ ${common:t} == .git ]]; then
    name=${common:h:t}
  else
    name=${${common:t}%.git}
  fi
  [[ $common == $top/.git && -z $_herdr_workspace_label ]] && return
  [[ $name == $_herdr_workspace_label ]] && return
  _herdr_workspace_label=$name
  herdr workspace rename "$HERDR_WORKSPACE_ID" "$name" >/dev/null 2>&1 &!
}
add-zsh-hook chpwd _herdr_sync_workspace_label
zsh-defer _herdr_sync_workspace_label

# herdr の goto picker はエージェントのいない pane を "terminal · 2" と表示するので、
# 待機中はディレクトリ名、実行中はコマンド名を pane 名にする
# エージェント実行中は pane 名がタイトルより優先されてしまうため名前を外す
_herdr_set_pane_label() {
  [[ -n $HERDR_PANE_ID && $1 != $_herdr_pane_label ]] || return
  _herdr_pane_label=$1
  if [[ -n $1 ]]; then
    herdr pane rename "$HERDR_PANE_ID" "$1" >/dev/null 2>&1 &!
  else
    herdr pane rename --clear "$HERDR_PANE_ID" >/dev/null 2>&1 &!
  fi
}
_herdr_pane_label_precmd() {
  _herdr_set_pane_label "${${PWD/#$HOME/~}:t}"
}
_herdr_pane_label_preexec() {
  local -a words expanded_words
  words=(${(z)1}) expanded_words=(${(z)2})
  local cmd=${words[1]:t} expanded=${expanded_words[1]:t}
  case "$cmd:$expanded" in
    (claude:*|codex:*|cx:*|*:claude|*:codex|devclaude:*|devcontainer:*) _herdr_set_pane_label "" ;;
    (*) _herdr_set_pane_label "$cmd" ;;
  esac
}
add-zsh-hook precmd _herdr_pane_label_precmd
add-zsh-hook preexec _herdr_pane_label_preexec

# -------------------
# Other Settings
# -------------------

# dotfiles
export DOT_DIR="$HOME/src/github.com/EkeMinusYou"

# suppress prompt
export LISTMAX=10000

# history
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_NO_STORE
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt AUTO_PUSHD
setopt AUTO_CD
setopt PUSHD_IGNORE_DUPS

zshaddhistory() {
  local line=${1%%$'\n'}
  local cmd=${line%% *}

  # Only those that satisfy all of the following conditions are added to the history
  [[ ${#line} -ge 5
    && ${cmd} != more
    && ${cmd} != less
    && ${cmd} != devclaude
  ]]
}

# coreutils
case ${OSTYPE} in
  darwin*)
    alias ln="gln"
    alias wc="gwc"
    ;;
  linux*)
    ;;
esac

# pipe
alias -g C='| wc -l'
alias -g G='| grep'
alias -g H='| head'
alias -g L='| less'
alias -g M='| more'
alias -g T='| tail'
alias -g J='| jq'
alias -g Y='| yq'
alias -g P='| pbcopy'

# cd
alias c="cd"
alias ...="cd ../.."

# lsd
alias l="ls"
alias ll="ls -la"
alias ls="lsd"

# vim
alias v="nvim"
alias vim="nvim"

# herdr
alias hd="herdr"

# Default Editor
export EDITOR=$HOMEBREW_PREFIX/bin/nvim

# aqua
export AQUA_GLOBAL_CONFIG=$HOME/.config/aqua/aqua.yaml
# private リポジトリ(groove-x/aqua-registry など)用の GitHub トークンをキーチェーンから読む。`aqua token set` で保存する
export AQUA_KEYRING_ENABLED=true

# Git
export GPG_TTY=$TTY
alias g="git"
alias cr='cd "$(git rev-parse --show-toplevel)"'
alias ga="git add"
alias gpl="git pull"
alias gplr="git pull --rebase origin"
alias gst="git stash -u"
alias gsta="git stash apply"
alias gcm="git commit -m"
alias gco="git checkout"
alias gsw="git switch"
alias gsc="git switch --create"
alias gps="git push"
alias gpsf="git push --force-with-lease"
alias glgo="git log --oneline"
alias grh="git reset --soft HEAD\^"
alias gcom="git switch \$(gh repo view --json defaultBranchRef --jq .defaultBranchRef.name)"
alias gplrm="git pull --rebase origin \$(gh repo view --json defaultBranchRef --jq .defaultBranchRef.name)"
alias ghs="gh api -X GET /user/starred --paginate --cache 24h | jq '.[].full_name' -r | fzf | xargs gh repo view --web"

# GitHub
alias ghb="gh browse"
alias ghpw="gh pr view --web"
alias ghpc="gh pr create"

# Worktrunk
alias wts="wt switch --create"
alias wtr="wt switch ^"
if whence -p wt >/dev/null; then
  _zsh_source_cached worktrunk wt config shell init zsh
fi

# Kubernetes
alias k="kubectl"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kl="kubectl logs"
alias kt="kubectl top"
alias kr="kubectl rollout"

# k9s
alias k9="k9s --readonly"

# Terraform
alias tf="terraform"
alias tff="terraform fmt"
alias tfp="terraform plan"
alias tfa="terraform apply"
alias tfs="terraform state"
export TF_CLI_ARGS_plan="--parallelism=30"
export TF_CLI_ARGS_apply="--parallelism=30"
export TF_PLUGIN_CACHE_DIR=${XDG_CACHE_HOME:-$HOME/.cache}/terraform/plugin-cache
[[ -d $TF_PLUGIN_CACHE_DIR ]] || mkdir -p $TF_PLUGIN_CACHE_DIR

# Go
export GOPROXY="https://proxy.golang.org,direct"
export GOPRIVATE=github.com/groove-x

# Java
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@21/include"

# VSCode
alias e='code -a .'

# gcloud
export USE_GKE_GCLOUD_AUTH_PLUGIN=true
export CLOUDSDK_PYTHON=""

# gxcloud
alias gx=gxcloud

# direnv
export DIRENV_LOG_FORMAT=
if whence -p direnv >/dev/null; then
  _zsh_source_cached direnv direnv hook zsh
fi

# tccli
complete -C 'tccli_completer' tccli

# terraform
complete -o nospace -C terraform terraform

# Node.js
alias nr="npm run"

# wsl
export LD_LIBRARY_PATH=/usr/lib/wsl/lib:$LD_LIBRARY_PATH

# codex
export CODEX_HOME="${CODEX_HOME:-$XDG_CONFIG_HOME/codex}"

# claude
alias devclaude="devcontainer up --workspace-folder . --config ~/.config/devcontainer/claude/devcontainer.json && devcontainer exec --workspace-folder . --config ~/.config/devcontainer/claude/devcontainer.json claude"
export CLAUDE_CONFIG_DIR=~/.config/claude

# difit
alias difit="bunx difit"

# codex
alias cx="codex"

# lazypencil
alias lp="lazypencil"

# -------------------
# Functions
# -------------------

function ghq-fzf() {
  local src=$(ghq list --full-path | fzf --preview "bat --color=always --style=header,grid --line-range :80 {}/README.*")
  if [ -n "$src" ]; then
    BUFFER="cd \"$src\""
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf

function cdr-fzf() {
  local src=$(cdr -l | awk '{print $2}' | fzf --height 40% --reverse)
  if [ -n "$src" ]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N cdr-fzf
bindkey '^z' cdr-fzf

local no_expand_commands=("ls" "ll" "ln" "wc")

function expand-alias() {
  local words=(${(z)LBUFFER})
  local word="${words[-1]}"
  if [[ ! "${no_expand_commands[(r)$word]}" ]]; then
    zle _expand_alias
  fi
  zle self-insert
}
zle -N expand-alias
bindkey -M main ' ' expand-alias

function expand-alias-accept-line() {
  local words=(${(z)LBUFFER})
  local word="${words[-1]}"
  if [[ ! "${no_expand_commands[(r)$word]}" ]]; then
    zle _expand_alias
  fi
  zle .reset-prompt
  zle .accept-line
}
zle -N accept-line expand-alias-accept-line

function paste-as-yank() {
  BUFFER=$(pbpaste)
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N paste-as-yank
bindkey '^y' paste-as-yank

# See: https://sushichan044.hateblo.jp/entry/2025/06/06/003325
function fzf-worktree() {
  local src=$(fd --hidden --no-ignore --type f --max-depth 4 '^\.git$' "$HOME/worktrees" | sed 's#/.git$##' | fzf \
    --preview "echo '📦 Branch:' && git -C {1} branch --show-current && echo '' && echo '📝 Changed files:' && git -C {1} status --porcelain | head -10 && echo '' && echo '📚 Recent commits:' && git -C {1} log --oneline --decorate -10")
  if [ -n "$src" ]; then
    BUFFER="cd \"$src\""
    zle accept-line
  fi
  zle -R -c
}
zle -N fzf-worktree
bindkey '^x' fzf-worktree

gifit() {
  local from_commit to_commit from_hash to_hash

  from_commit=$(git log --oneline --decorate -100 --color=always | \
    fzf \
      --ansi \
      --header "> difit \$TO \$FROM~1" \
      --prompt "Select \$FROM>" \
      --preview 'git log --oneline --decorate --color=always -1 {1}' \
      --preview-window=top:3:wrap
  ) || return
  from_hash="${from_commit%% *}"

  to_commit=$(git log --oneline --decorate -100 --color=always $from_hash~1.. | \
    fzf \
      --ansi \
      --header "> difit \$TO $from_hash~1" \
      --prompt "Select \$TO>" \
      --preview 'git log --oneline --decorate --color=always -1 {1}' \
      --preview-window=top:3:wrap
  ) || return
  to_hash="${to_commit%% *}"

  difit "$to_hash" "$from_hash~1"
}

# -------------------
# zsh-defer source
# -------------------

# autopair
zsh-defer source $HOMEBREW_PREFIX/share/zsh-autopair/autopair.zsh
# gcloud
zsh-defer -c "test -e $HOME/google-cloud-sdk/path.zsh.inc && source $HOME/google-cloud-sdk/path.zsh.inc || true"
zsh-defer -c "test -e $HOME/google-cloud-sdk/completion.zsh.inc && source $HOME/google-cloud-sdk/completion.zsh.inc || true"
# iterm2
zsh-defer -c "test -e $HOME/.iterm2_shell_integration.zsh && source $HOME/.iterm2_shell_integration.zsh || true"

zsh-defer zellij_tab_name_update

# -------------------
# Starship
# -------------------

export STARSHIP_LOG="error"
_zsh_source_cached starship starship init zsh

# -------------------
# zellij
# -------------------

if [[ -z "$ZELLIJ" ]] && [[ "$TERM_PROGRAM" == "Alacritty" ]]; then
  if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
    zellij attach -c
  else
    zellij
  fi
  if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
    exit
  fi
fi

# -------------------
# VSCode
# -------------------

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# -------------------
# fzf
# -------------------

_zsh_source_cached fzf fzf --zsh
# catppuccin
# See: https://github.com/catppuccin/fzf
# Ask the terminal for its background color (OSC 11) to pick latte or mocha
_terminal_is_light() {
  [[ -t 0 && -t 1 ]] || return 1
  local stty_save=$(stty -g) reply="" c
  stty raw -echo min 0 time 1
  printf '\e]11;?\e\\' > /dev/tty
  while read -rs -k 1 -t 0.2 c < /dev/tty; do
    reply+=$c
    [[ $c == $'\a' || $reply == *$'\e\\' ]] && break
  done
  stty $stty_save
  [[ $reply =~ 'rgb:([0-9a-fA-F]{2})[0-9a-fA-F]*/([0-9a-fA-F]{2})[0-9a-fA-F]*/([0-9a-fA-F]{2})' ]] || return 1
  (( 16#${match[1]} + 16#${match[2]} + 16#${match[3]} > 384 ))
}
if _terminal_is_light; then
  _fzf_colors="--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
--color=marker:#7287fd,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39 \
--color=bg+:#ccd0da,hl:#d20f39,spinner:#dc8a78,border:#9ca0b0"
else
  _fzf_colors="--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
fi
export FZF_DEFAULT_OPTS=" \
--height=50% \
--layout=reverse \
$_fzf_colors"
unset _fzf_colors

[[ "$TERM" == "xterm-ghostty" ]] && export TERM="xterm-256color"

# -------------------
# Profiling
# -------------------

# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi
