#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$HOME/.local/bin"
COMMAND_PATH="$BIN_DIR/kapat"
MARKER_BEGIN="# >>> kapat command PATH >>>"
MARKER_END="# <<< kapat command PATH <<<"

mkdir -p "$BIN_DIR"
install -m 0755 "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/kapat" "$COMMAND_PATH"

add_path_to_file() {
  local file="$1"
  mkdir -p "$(dirname -- "$file")"
  touch "$file"
  if ! grep -Fq "$MARKER_BEGIN" "$file"; then
    cat >> "$file" <<'PATH_BLOCK'

# >>> kapat command PATH >>>
export PATH="$HOME/.local/bin:$PATH"
# <<< kapat command PATH <<<
PATH_BLOCK
  fi
}

shell_name="$(basename -- "${SHELL:-bash}")"
case "$shell_name" in
  fish)
    fish_conf="$HOME/.config/fish/conf.d/kapat-path.fish"
    mkdir -p "$(dirname -- "$fish_conf")"
    cat > "$fish_conf" <<'FISH_BLOCK'
# PATH for the kapat command
fish_add_path --path "$HOME/.local/bin"
FISH_BLOCK
    ;;
  zsh)
    add_path_to_file "$HOME/.zshrc"
    ;;
  bash|sh)
    add_path_to_file "$HOME/.bashrc"
    ;;
  *)
    add_path_to_file "$HOME/.profile"
    ;;
esac

printf '\nInstalled successfully: %s\n' "$COMMAND_PATH"
printf 'Restart your terminal, or reload your shell configuration, then type: kapat\n'
printf 'WARNING: Running "kapat" immediately shuts down the computer. Save your work first.\n'
