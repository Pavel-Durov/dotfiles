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
		-avh --no-perms . "${TARGET}";
  cp "${TARGET}/config/.bash_profile" ${HOME}/.bash_profile
  cp "${TARGET}/config/.vimrc" ${HOME}/.vimrc
  cp "${TARGET}/config/.gitconfig" ${HOME}/.gitconfig
 	source ${HOME}/.bash_profile;
}

function mac-install(){
  source ${PWD}/system/.functions.sh
  ${PWD}/bin/is-macos && ${PWD}/bin/is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
  ${PWD}/bin/is-macos && brew bundle --file=${PWD}/install/Caskfile || true
}

function arch-install(){
  source ${PWD}/system/.functions.sh
  /usr/bin/pacman -sS - < ./install/pac_pkgs.txt
}

function install() {
  if [[ "$OSTYPE" =~ ^darwin ]]; then
    mac-install
  elif [ -f "/etc/arch-release" ]; then
    arch-install
  else
    echo "TODO: add linux install"
  fi
}

if [ "$1" == "--config" -o "$1" == "-c" ]; then
	init-config
elif [ "$1" == "--install" -o "$1" == "-i" ]; then
  install
else
	read -p "This action will overwrite existing files in your ${HOME} directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
	  init-config
		install
	fi;
fi;
unset init;
