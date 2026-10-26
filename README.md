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
brew bundle --file "$HOME/src/github.com/EkeMinusYou/dotfiles/Brewfile"
```

### Contents

- Brewfile
- zsh setting
- Git config
- Neovim setting

### Shell

- zsh - shell
- [fzf](https://github.com/junegunn/fzf) - fuzzy finder

Generated Sheldon, Worktrunk, Starship, and fzf initialization scripts are cached and compiled under
`${XDG_CACHE_HOME}/zsh` (default: `~/Library/Caches/zsh` on macOS, `~/.cache/zsh` on Linux).
They refresh automatically when the executable, `.zshrc`, or Sheldon configuration/lock file changes.
The cache directory contains generated files only; removing it safely rebuilds them on startup or first use.
Autocomplete loads through Sheldon's default template, before custom scripts and key bindings.
It manages `compinit` and completion registrations itself; completion security checks remain enabled.
Worktrunk, direnv, Starship, and fzf load their unmodified generated initialization scripts during startup.
PATH entries are deduplicated and configured once, preserving their search order.
Only generated scripts in the cache directory are compiled; `.zshrc` and third-party plugin sources are not.

Completions for kubectl, atlas, docker, soracom, codex, gxcloud, lovot, and npm are
generated on first use in each shell and cached in the same directory. After upgrading
a command, its completions refresh automatically on first use in a new shell.
Aqua-managed commands are checked against the selected package executable, not just the proxy.
The direnv hook is cached automatically, and Homebrew environment variables are set directly.
There is no need to run `update.sh` for shell setup; it now only copies the macSKK settings.
Custom completion files in `~/.zsh/fpath` and scripts in `~/.zsh/scripts` still load.

Measure warm startup with [hyperfine](https://github.com/sharkdp/hyperfine):

```sh
TERM=xterm-256color hyperfine --warmup 3 --runs 30 --export-json /tmp/zsh-startup.json \
  'zsh -i -c "exit 0"' 'zsh -l -i -c "exit 0"'
```

This measures shell initialization and exit; Autocomplete's first-prompt completion setup,
prompt rendering, and idle-time deferred plugins are excluded.
The first launch after a cache refresh also generates the initialization scripts.

### Worktrees

Worktrunk creates worktrees under `~/worktrees/<owner>/<repo>/<branch>/`, with `/` in branch names replaced by `-`. Shell integration enables directory switching and completion. `Ctrl-X` searches worktrees across repositories.

```bash
wt switch --create feature/new-ui
wt switch feature/new-ui
wt remove feature/new-ui
```

When a repository has `.worktreeinclude`, the post-start hook copies matching gitignored files from its primary worktree. Without that file, it copies nothing.
