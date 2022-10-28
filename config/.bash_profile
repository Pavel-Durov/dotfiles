#!/usr/bin/env bash
# kimchi dotfiles

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";
TARGET="${HOME}/.dotfiles/system"
for file in ${TARGET}/.*; do
	[ -r "$file" ] && [ -f "$file" ] && source "${file}";
done;
echo ".files: ${TARGET}"
shopt -s cdspell

# Direnv
source ${HOME}/.envrc
eval "$(direnv hook bash)"
