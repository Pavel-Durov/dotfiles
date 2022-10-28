#!/usr/bin/env bash

TARGET="${HOME}/.dotfiles"

function init-config(){
  rm -fr ${TARGET}
  mkdir ${TARGET}
  rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE" \
		-avh --no-perms . ${HOME}/.dotfiles;
	source ${HOME}/.bash_profile;
}

function mac-install(){
  source ${PWD}/system/.functions
  ${PWD}/bin/is-macos && ${PWD}/bin/is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
  ${PWD}/bin/is-macos && brew bundle --file=${PWD}/install/Caskfile || true
}

function init() {
  init-config
  # mac-install
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	init;
else
	read -p "This action will overwrite existing files in your ${HOME} directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		init;
	fi;
fi;
unset init;
