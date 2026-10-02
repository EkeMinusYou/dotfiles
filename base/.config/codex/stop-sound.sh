#!/bin/sh
# codex の Stop フック: ターン完了時に Ping を鳴らす。
# herdr 内の codex は herdr が通知音を鳴らすので重複させない。
# フックは herdr の外で起動した app-server daemon で動き HERDR_PANE_ID が渡らないため、
# フック入力の cwd で動いている codex ペインが herdr にあるかを見て判定する。

input=$(cat)

[ -n "${HERDR_PANE_ID:-}" ] && exit 0

cwd=$(printf '%s' "$input" | jq -r '.cwd // empty' 2>/dev/null)
herdr=$(command -v herdr || echo /opt/homebrew/bin/herdr)
if [ -n "$cwd" ] && "$herdr" pane list 2>/dev/null |
  jq -e --arg cwd "$cwd" '.result.panes[] | select(.agent == "codex" and (.foreground_cwd == $cwd or .cwd == $cwd))' >/dev/null 2>&1; then
  exit 0
fi

afplay /System/Library/Sounds/Ping.aiff >/dev/null 2>&1 || true
