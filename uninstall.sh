#!/usr/bin/env bash
set -euo pipefail

COMMAND_PATH="$HOME/.local/bin/kapat"
MARKER_BEGIN="# >>> kapat command PATH >>>"
MARKER_END="# <<< kapat command PATH <<<"

remove_path_block() {
  local file="$1"
  [[ -f "$file" ]] || return 0
  if grep -Fq "$MARKER_BEGIN" "$file"; then
    awk -v begin="$MARKER_BEGIN" -v end="$MARKER_END" '
      $0 == begin { skip=1; next }
      $0 == end { skip=0; next }
      !skip { print }
    ' "$file" > "$file.tmp"
    mv "$file.tmp" "$file"
  fi
}

rm -f "$COMMAND_PATH"
remove_path_block "$HOME/.bashrc"
remove_path_block "$HOME/.zshrc"
remove_path_block "$HOME/.profile"
rm -f "$HOME/.config/fish/conf.d/kapat-path.fish"
printf 'Removed the kapat command and its PATH configuration.\n'
